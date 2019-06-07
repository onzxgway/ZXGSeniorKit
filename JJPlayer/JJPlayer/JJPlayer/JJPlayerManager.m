//
//  JJPlayerManager.m
//  JJPlayer
//
//  Created by 朱献国 on 2019/6/5.
//  Copyright © 2019 朱献国. All rights reserved.
//

#import "JJPlayerManager.h"

static NSString *const status                   = @"status";
static NSString *const loadedTimeRanges         = @"loadedTimeRanges";
static NSString *const playbackBufferEmpty      = @"playbackBufferEmpty";
static NSString *const playbackLikelyToKeepUp   = @"playbackLikelyToKeepUp";
static NSString *const presentationSize         = @"presentationSize";


@interface JJPlayerManager ()
@property (nonatomic) BOOL isPreparedToPlay;
@property (nonatomic, strong) JJPlayerKVOObserver *KVOObserver;
@property (nonatomic) BOOL isBuffering; // 是否正在缓冲.
@end

@implementation JJPlayerManager {
    id _timeObserver;
    id _didPlayToEndTimeObserver;
}

@synthesize assetURL = _assetURL;
@synthesize view = _view;
@synthesize videoGravity = _videoGravity;
@synthesize shouldAutoPlay = _shouldAutoPlay;
@synthesize refreshInterval = _refreshInterval;
@synthesize playerPlayTimeChanged = _playerPlayTimeChanged;
@synthesize playerDidToEnd = _playerDidToEnd;
@synthesize presentationSize = _presentationSize;
@synthesize presentationSizeChanged = _presentationSizeChanged;
@synthesize playState = _playState;
@synthesize playerPlayStateChanged = _playerPlayStateChanged;
@synthesize bufferTime = _bufferTime;
@synthesize playerBufferTimeChanged = _playerBufferTimeChanged;
@synthesize requestHeader = _requestHeader;
@synthesize playerPrepareToPlay = _playerPrepareToPlay;

- (instancetype)init {
    self = [super init];
    if (self) {
        _shouldAutoPlay = YES;
    }
    return self;
}

#pragma mark - Private Methods
- (void)createPlayer {
    // 0.初始化播放器
    _asset = [AVURLAsset URLAssetWithURL:_assetURL options:self.requestHeader];
    AVPlayerItem *_playerItem = [AVPlayerItem playerItemWithAsset:self.asset];
    _player = [AVPlayer playerWithPlayerItem:_playerItem];
    
    // 1.播放画面添加到view上
    JJPlayerPresentView *presentView = (JJPlayerPresentView *)self.view;
    presentView.player = _player;
    self.videoGravity = AVLayerVideoGravityResizeAspect;
    
    // 2._playerItem添加监听
    [self itemObserving];
}

- (void)seekToTime:(NSTimeInterval)time completionHandler:(void(^)(BOOL))completionHandler {
    
    if (self.totalTime > 0) {
        CMTime seekTime = CMTimeMake(time, 1);
        [self.player seekToTime:seekTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:completionHandler];
    }
    else {
        
    }
    
}

// 缓冲较差时候回调这里
- (void)bufferingSomeSeconds {
    // playbackBufferEmpty会反复进入，因此在bufferingOneSecond延时播放执行完之前再调用bufferingSomeSecond都忽略
    if (_isBuffering || self.playState == JJPlayerPlayStatePlayStopped) return;
    _isBuffering = YES;
    
    // 需要先暂停一小会之后再播放，否则网络状况不好的时候时间在走，声音播放不出来
    [self.player pause];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 如果此时用户已经暂停了，则不再需要开启播放了
        if (self.playState == JJPlayerPlayStatePaused || self.playState == JJPlayerPlayStatePlayStopped) {
            self.isBuffering = NO;
            return;
        }
        [self play];
        
        self.isBuffering = NO;
        // 如果执行了play还是没有播放则说明还没有缓存好，则再次缓存一段时间
        if (!self.player.currentItem.isPlaybackLikelyToKeepUp) [self bufferingSomeSeconds];
    });
}

// 计算缓冲时长
- (NSTimeInterval)availableDuration {
    NSArray<NSValue *> *timeRangeArray = self.player.currentItem.loadedTimeRanges;
    CMTime currentTime = [self.player currentTime];
    BOOL foundRange = NO;
    CMTimeRange aTimeRange = {0};
    if (timeRangeArray.count) {
        aTimeRange = [[timeRangeArray firstObject] CMTimeRangeValue]; // 本次缓冲时间范围
        if (CMTimeRangeContainsTime(aTimeRange, currentTime)) {
            foundRange = YES;
        }
    }
    
    if (foundRange) {
        CMTime maxTime = CMTimeRangeGetEnd(aTimeRange);
        NSTimeInterval playableDuration = CMTimeGetSeconds(maxTime);
        if (playableDuration > 0) {
            return playableDuration;
        }
    }
    return 0;
}

#pragma mark - KVO
- (void)itemObserving {
    // 0.监听AVPlayerItem的相关属性
    [_KVOObserver jj_removeAllObservers];
    _KVOObserver = [[JJPlayerKVOObserver alloc] initWithTarget:_player.currentItem];
    [_KVOObserver jj_addObserver:self
                      forKeyPath:status
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    [_KVOObserver jj_addObserver:self
                      forKeyPath:playbackBufferEmpty
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    [_KVOObserver jj_addObserver:self
                      forKeyPath:playbackLikelyToKeepUp
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    [_KVOObserver jj_addObserver:self
                      forKeyPath:loadedTimeRanges
                         options:NSKeyValueObservingOptionNew
                         context:nil]; // 已经缓冲的进度
    [_KVOObserver jj_addObserver:self
                      forKeyPath:presentationSize
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    /**
     AVPlayerItem.duration属性 支持KVO,
     [AVPlayerItem currentTime] 不支持KVO，要监听必须通过AVPlayer的addPeriodicTimeObserverForInterval:方法
     */
    // 1.定周期监听AVPlayer的时间相关
    CMTime interval = CMTimeMakeWithSeconds(_refreshInterval ?: 0.2, NSEC_PER_SEC);
    @weakify(self)
    _timeObserver = [self.player addPeriodicTimeObserverForInterval:interval queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        @strongify(self)
        if (!self) return;
        
//        NSLog(@"CMTime::%lf", CMTimeGetSeconds(time)); // 当前播放时间点
        if (self.playerPlayTimeChanged) {
            self.playerPlayTimeChanged(self, self.currentTime, self.totalTime);
        }
    }];
    
    // 2.播放结束监听
    _didPlayToEndTimeObserver = [[NSNotificationCenter defaultCenter] addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        @strongify(self)
        if (!self) return;
        
        self.playState = JJPlayerPlayStatePlayStopped;

        if (self.playerDidToEnd) {
            self.playerDidToEnd(self);
        }
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    // 当status等于AVPlayerStatusReadyToPlay时代表视频资源准备好了，已经可以播放了。
    if ([keyPath isEqualToString:status]) {
        NSLog(@"=====status=====");
        AVPlayerItem *item = self.player.currentItem;
        if (item.status == AVPlayerItemStatusReadyToPlay) {
        
        }
        else if (item.status == AVPlayerItemStatusFailed){
            self.playState = JJPlayerPlayStatePlayFailed;
            NSError *error = self.player.currentItem.error;
            if (self.playerPlayFailed) self.playerPlayFailed(self, error);
        }
    }
    else if ([keyPath isEqualToString:playbackBufferEmpty]) {
        NSLog(@"=====playbackBufferEmpty=====");
        // 播放已消耗所有缓冲媒体，且播放将停止或结束
        if (self.player.currentItem.isPlaybackBufferEmpty) {
            [self bufferingSomeSeconds];
        }
    }
    else if ([keyPath isEqualToString:playbackLikelyToKeepUp]) {
        NSLog(@"=====playbackLikelyToKeepUp=====");
        // 是否可能在不停顿的情况下完成
        if (self.player.currentItem.isPlaybackLikelyToKeepUp) {
//            self.loadState = ZFPlayerLoadStatePlayable;
            if (self.playState == JJPlayerPlayStatePlaying) [self.player play];
        }
    }
    else if ([keyPath isEqualToString:loadedTimeRanges]) {
        // 监听此属性可以在UI中更新缓冲进度
        NSTimeInterval bufferTime = [self availableDuration];
        _bufferTime = bufferTime;
        if (self.playerBufferTimeChanged) {
            self.playerBufferTimeChanged(self, bufferTime);
        }
    }
    else if ([keyPath isEqualToString:presentationSize]) {
        NSLog(@"=====presentationSize=====");
        _presentationSize = self.player.currentItem.presentationSize;
        if (self.presentationSizeChanged) {
            self.presentationSizeChanged(self, _presentationSize);
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}

#pragma mark - JJPlayerMediaPlayback Methods
// 播放前准备
- (void)prepareToPlay {
    
    if (!_assetURL) return;
    _isPreparedToPlay = YES;
    [self createPlayer];
    if (_shouldAutoPlay) {
        [self play];
    }
//    self.loadState = ZFPlayerLoadStatePrepare;
    if (self.playerPrepareToPlay) self.playerPrepareToPlay(self, self.assetURL);
    
}

// 播放.
- (void)play {
    if (!_isPreparedToPlay) {
        [self prepareToPlay];
    }
    else {
        [self.player play];
        self.playState = JJPlayerPlayStatePlaying;
    }
}

// 暂停.
- (void)pause {
    [self.player pause];
    self.playState = JJPlayerPlayStatePaused;
}

// 停止. 恢复初始设置，销毁AVPlayer.(销毁之前，先把currentItem置nil)
//
- (void)stop {
    
    // 移除所有监听
    [_KVOObserver jj_removeAllObservers];
    
    [self.player removeTimeObserver:_timeObserver];
    _timeObserver = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:_didPlayToEndTimeObserver];
    _didPlayToEndTimeObserver = nil;
    
    // 切换player的currentItem到nil
    [self.player replaceCurrentItemWithPlayerItem:nil];
    
    _player = nil;
    _assetURL = nil;
    _isPreparedToPlay = NO;
    
    self.playState = JJPlayerPlayStatePlayStopped;
    
//    _currentTime = 0;
//    _totalTime = 0;
//    self->_bufferTime = 0;
}

// 重播.
- (void)replay {
    @weakify(self)
    [self seekToTime:0 completionHandler:^(BOOL finished) {
        @strongify(self)
        [self play];
    }];
    
}

#pragma mark - Getter
- (JJPlayerView *)view {
    if (!_view) {
        _view = [[JJPlayerPresentView alloc] init];
    }
    return _view;
}

- (NSTimeInterval)totalTime {
    
    NSTimeInterval sec = CMTimeGetSeconds(self.player.currentItem.duration);
    // 如果一个数是确定的，那它就不是nan值 如果一个数是无穷大或者无穷小，那它就是nan值
    if (isnan(sec)) {
        return 0;
    }
    return sec;
}

- (NSTimeInterval)currentTime {
    NSTimeInterval sec = CMTimeGetSeconds(self.player.currentItem.currentTime);
    if (isnan(sec) || sec < 0) {
        return 0;
    }
    return sec;
}

#pragma mark - Setter
- (void)setVideoGravity:(AVLayerVideoGravity)videoGravity {
    _videoGravity = videoGravity;
    
    JJPlayerPresentView *presentView = (JJPlayerPresentView *)self.view;
    if ([_videoGravity isEqualToString:AVLayerVideoGravityResizeAspect]) {
        presentView.videoGravity = AVLayerVideoGravityResizeAspect; // 不变形，填充不全，有黑边
    }
    else if ([_videoGravity isEqualToString:AVLayerVideoGravityResizeAspectFill]) {
        presentView.videoGravity = AVLayerVideoGravityResizeAspectFill; // 不变形，填充满，部分画面被截
    }
    else if ([_videoGravity isEqualToString:AVLayerVideoGravityResize]) {
        presentView.videoGravity = AVLayerVideoGravityResize; // 画面变形 充满页面
    }

}

- (void)setAssetURL:(NSURL *)assetURL {
    if (self.player) {
        [self stop];
    }
    _assetURL = assetURL;
    [self prepareToPlay];
}

- (void)setPlayState:(JJPlayerPlayState)playState {
    _playState = playState;
    if (self.playerPlayStateChanged) {
        self.playerPlayStateChanged(self, _playState);
    }
}

@end
