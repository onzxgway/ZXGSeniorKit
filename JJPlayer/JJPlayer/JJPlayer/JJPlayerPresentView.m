//
//  JJPlayerPresentView.m
//  JJPlayer
//
//  Created by 朱献国 on 2019/6/4.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "JJPlayerPresentView.h"

@implementation JJPlayerPresentView

#pragma mark - 需求一：当前View.layer是CALayer实例,把它替换为AVPlayerLayer实例。
+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorRandomColor;
    }
    return self;
}

#pragma mark - getter
- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)self.layer;
}

#pragma mark - setter
- (void)setPlayer:(AVPlayer *)player {
    if (_player == player) return;
    _player = player;
    self.playerLayer.player = _player;
}

- (void)setVideoGravity:(AVLayerVideoGravity)videoGravity {
    if (videoGravity == self.videoGravity) return;
    self.playerLayer.videoGravity = videoGravity;
}

- (AVLayerVideoGravity)videoGravity {
    return self.playerLayer.videoGravity;
}

@end
