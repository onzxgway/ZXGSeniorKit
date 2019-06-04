//
//  ViewController.m
//  JJPlayer
//
//  Created by 朱献国 on 2019/6/4.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "JJPlayerPresentView.h"

@interface ViewController ()
@property (nonatomic, strong) JJPlayerPresentView *playerPresentView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.playerPresentView];
    [self.playerPresentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(188);
        make.right.left.mas_equalTo(0.f);
        make.height.mas_equalTo(238.f);
    }];
    
    [self createPlayer];
}

- (void)createPlayer {
    AVURLAsset *URLAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:@"https://fcvideo.cdn.bcebos.com/smart/f103c4fc97d2b2e63b15d2d5999d6477.mp4"] options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:URLAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    
    self.playerPresentView.player = player;
    
    if (@available(iOS 9.0, *)) {
        playerItem.canUseNetworkResourcesForLiveStreamingWhilePaused = NO;
    }
    if (@available(iOS 10.0, *)) {
        playerItem.preferredForwardBufferDuration = 5;
        player.automaticallyWaitsToMinimizeStalling = NO;
    }
    
    [player play];
}

- (JJPlayerPresentView *)playerPresentView {
    if (!_playerPresentView) {
        _playerPresentView = [[JJPlayerPresentView alloc] init];
    }
    return _playerPresentView;
}

@end
