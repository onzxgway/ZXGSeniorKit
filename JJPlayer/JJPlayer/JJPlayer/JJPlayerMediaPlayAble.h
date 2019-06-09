//
//  JJPlayerMediaPlayAble.h
//  JJPlayer
//
//  Created by 朱献国 on 2019/6/5.
//  Copyright © 2019 朱献国. All rights reserved.
//

#import "JJPlayerView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JJPlayerPlayState) {
    JJPlayerPlayStateUnknown = 0,   // 
    JJPlayerPlayStateFailed,        // 播放准备失败
    JJPlayerPlayStatePlaying,       // 播放中
    JJPlayerPlayStatePaused,        // 暂停
    JJPlayerPlayStateDidPlayToEnd   // 播放完成
};

typedef NS_OPTIONS(NSUInteger, JJPlayerLoadState) {
    JJPlayerLoadStateUnknown        = 0,
    JJPlayerLoadStatePrepare        = 1 << 0,
    JJPlayerLoadStatePlayable       = 1 << 1,
    JJPlayerLoadStatePlaythroughOK  = 1 << 2, // Playback will be automatically started.
    JJPlayerLoadStateStalled        = 1 << 3, // Playback will be automatically paused in this state, if started.
};

@protocol JJPlayerMediaPlayAble <NSObject>

@required
// 视频页面控件必须继承自 JJPlayerView,因为该类处理了很多手势冲突.
@property (nonatomic) JJPlayerView *view; // 视频页面

@optional
// 播放器音量。
// 只影响播放器实例的音频音量，不影响设备。
// 您可以根据需要更改设备音量或播放器音量，更改播放器音量您可以遵循“ZFPlayerMediaPlayback”协议。
@property (nonatomic) float volume;

// 播放器静音了。
// 指示播放器的音频输出是否为静音。只影响播放器实例的音频静音，而不影响设备。
// 你可以根据需要改变设备音量或播放器静音，改变播放器静音你可以遵循“ZFPlayerMediaPlayback”协议。
@property (nonatomic, getter=isMuted) BOOL muted;

// 播放速度, 0表示“暂停”，1表示自然速度播放。值必须大于零。
@property (nonatomic) float rate;

// 视频地址
@property (nonatomic, strong) NSURL *assetURL;
// 视频请求头 (可用于安全认证等)
@property (nonatomic, strong, nullable) NSDictionary *requestHeader;

// 是否自动播放, 默认是 YES.
@property (nonatomic) BOOL shouldAutoPlay;

// 播放时间 回调的时长间隔
@property (nonatomic) NSTimeInterval refreshInterval;

// 视频画面适应父Layer的方式. 默认是 AVLayerVideoGravityResizeAspect.
@property (nonatomic, copy) AVLayerVideoGravity videoGravity;

// 播放到的时间点.
@property (nonatomic, readonly) NSTimeInterval currentTime;

// 视频总时长.
@property (nonatomic, readonly) NSTimeInterval totalTime;

// 已缓冲时长.
@property (nonatomic, readonly) NSTimeInterval bufferTime;

// 寻求时间.
@property (nonatomic) NSTimeInterval seekTime;

// 是否是播放就绪状态(调用play即可播放)
@property (nonatomic, readonly) BOOL isPreparedToPlay;

// 视频画面尺寸.
@property (nonatomic, readonly) CGSize presentationSize;

// 播放状态.
@property (nonatomic, readonly) JJPlayerPlayState playState;

// 加载状态.
@property (nonatomic, readonly) JJPlayerLoadState loadState;

// 播放就绪状态回调.
@property (nonatomic, copy, nullable) void(^playerPrepareToPlay)(id<JJPlayerMediaPlayAble> asset, NSURL *assetURL);

// 将要播放回调.
@property (nonatomic, copy, nullable) void(^playerReadyToPlay)(id<JJPlayerMediaPlayAble> asset, NSURL *assetURL);

// 播放时间相关回调.
@property (nonatomic, copy, nullable) void(^playerPlayTimeChanged)(id<JJPlayerMediaPlayAble> asset, NSTimeInterval currentTime, NSTimeInterval duration);

// 播放结束回调.
@property (nonatomic, copy, nullable) void(^playerDidToEnd)(id<JJPlayerMediaPlayAble> asset);

// 视频画面尺寸变更回调.
@property (nonatomic, copy, nullable) void(^presentationSizeChanged)(id<JJPlayerMediaPlayAble> asset, CGSize size);

// 播放状态改变回调.
@property (nonatomic, copy, nullable) void(^playerPlayStateChanged)(id<JJPlayerMediaPlayAble> asset, JJPlayerPlayState playState);

// 加载状态改变回调.
@property (nonatomic, copy, nullable) void(^playerLoadStateChanged)(id<JJPlayerMediaPlayAble> asset, JJPlayerLoadState loadState);

// 播放器播放准备失败.
@property (nonatomic, copy, nullable) void(^playerPlayFailed)(id<JJPlayerMediaPlayAble> asset, NSError *error);

// 播放器缓冲增加回调.
@property (nonatomic, copy, nullable) void(^playerBufferTimeChanged)(id<JJPlayerMediaPlayAble> asset, NSTimeInterval bufferTime);

// 播放前准备
- (void)prepareToPlay;

// 播放.
- (void)play;

// 暂停.
- (void)pause;

// 停止.
- (void)stop;

// 重播.
- (void)replay;

// 刷新播放器.
- (void)reloadPlayer;

// 获取视频当前时间点对应的帧图片.
- (UIImage *)frameImageAtCurrentTime;

// 当前播放器查找到指定时间处，并在查找操作完成时得到通知
- (void)seekToTime:(NSTimeInterval)time completionHandler:(void(^__nullable)(BOOL))completionHandler;

@end

NS_ASSUME_NONNULL_END
