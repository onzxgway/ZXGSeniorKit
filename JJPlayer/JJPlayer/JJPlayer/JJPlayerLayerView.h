//
//  JJPlayerLayerView.h
//  JJPlayer
//
//  Created by 朱献国 on 2019/6/4.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "JJPlayerView.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 需求：AVPlayer播放器的画面呈现在该View上。
/**
 思路：
    1.AVFoundation框架当中有个继承自CALayer的AVPlayerLayer类，
    该类有个player属性，把AVPlayer实例赋值给该属性。就相当于播放器的画面layer添加到了AVPlayerLayer上面。
    2.当前View.layer是CALayer实例,把它替换为AVPlayerLayer实例。
 */


/**
 视频页面呈现控件
 在开发中单纯使用AVPlayer类是无法显示视频的，要将视频层添加至AVPlayerLayer中，这样才能将视频显示出来.
 */
@interface JJPlayerLayerView : JJPlayerView

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, copy  ) AVLayerVideoGravity videoGravity;

@end

NS_ASSUME_NONNULL_END
