//
//  JJPlayerMediaPlayAble.h
//  JJPlayer
//
//  Created by 朱献国 on 2019/6/5.
//  Copyright © 2019 朱献国. All rights reserved.
//

#import "JJPlayerView.h"

typedef NS_ENUM(NSUInteger, JJPlayerPlayState) {
    JJPlayerPlayStateUnknown = 0,
    JJPlayerPlayStatePlaying,       // 播放中
    JJPlayerPlayStatePaused,        // 暂停
    JJPlayerPlayStatePlayFailed,    // 播放器播放准备失败
    JJPlayerPlayStatePlayStopped    // 播放器释放了/播放结束
};

@protocol JJPlayerMediaPlayAble <NSObject>

@required
/// The view must inherited `JJPlayerView`,this view deals with some gesture conflicts.
@property (nonatomic) JJPlayerView *view; // 视频页面

@optional

// 播放地址
@property (nonatomic, strong) NSURL *assetURL;

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


@property (nonatomic, readonly) BOOL isPreparedToPlay;

// 视频画面尺寸.
@property (nonatomic, readonly) CGSize presentationSize;

// 播放状态.
@property (nonatomic, readonly) JJPlayerPlayState playState;


// 播放时间相关回调.
@property (nonatomic, copy) void(^playerPlayTimeChanged)(id<JJPlayerMediaPlayAble> asset, NSTimeInterval currentTime, NSTimeInterval duration);

// 播放结束回调.
@property (nonatomic, copy) void(^playerDidToEnd)(id<JJPlayerMediaPlayAble> asset);

// 视频画面尺寸变更回调.
@property (nonatomic, copy) void(^presentationSizeChanged)(id<JJPlayerMediaPlayAble> asset, CGSize size);

// 播放器播放状态改变回调.
@property (nonatomic, copy) void(^playerPlayStateChanged)(id<JJPlayerMediaPlayAble> asset, JJPlayerPlayState playState);

// 播放器播放准备失败.
@property (nonatomic, copy) void(^playerPlayFailed)(id<JJPlayerMediaPlayAble> asset, NSError *error);

// Prepares the current queue for playback, interrupting any active (non-mixible) audio sessions.
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


@end
