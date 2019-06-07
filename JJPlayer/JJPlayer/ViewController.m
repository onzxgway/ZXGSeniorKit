//
//  ViewController.m
//  JJPlayer
//
//  Created by 朱献国 on 2019/6/4.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "JJPlayerManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bufferLabel;

@property (nonatomic, strong) JJPlayerManager *playerManager;
@end

@implementation ViewController

- (IBAction)start:(UIButton *)sender {
    [self.playerManager play];
}

- (IBAction)pause:(UIButton *)sender {
    [self.playerManager pause];
}

- (IBAction)change:(id)sender {
    
    if (_playerManager) {
        self.playerManager.assetURL = [NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"];
    }
    
}

- (IBAction)replay:(UIButton *)sender {
    if (_playerManager) {
        [self.playerManager replay];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createPlayer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.playerManager stop];
}

#pragma mark - 视频拉流的画面的宽高比例，与播放器的宽高比例不符。如何解决？
- (void)createPlayer {
    
    /**
     0.JJPlayerManager实例化，给初始属性赋值。
     1.prepareToPlay方法主要做了三件事情。
        *创建了播放器对象。
        *把播放页面添加到父layer上。
        *AVPlayerItem实例的属性监听。
     */
    self.playerManager = [[JJPlayerManager alloc] init];
    self.playerManager.shouldAutoPlay = NO;
    
    self.playerManager.assetURL = [NSURL URLWithString:@"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4"];
    
    @weakify(self)
    [self.playerManager setPlayerPlayTimeChanged:^(id<JJPlayerMediaPlayAble> asset, NSTimeInterval currentTime, NSTimeInterval duration) {
        @strongify(self)
        
        self.totalTime.text = [NSString stringWithFormat:@"%lf", duration];
        self.currentTime.text = [NSString stringWithFormat:@"%lf", currentTime];
    }];
    
    [self.playerManager setPlayerDidToEnd:^(id<JJPlayerMediaPlayAble> asset) {
        @strongify(self)
        self.stateLabel.text = @"播放结束";
    }];
    
    [self.playerManager setPlayerBufferTimeChanged:^(id<JJPlayerMediaPlayAble> asset, NSTimeInterval bufferTime) {
        @strongify(self)
        self.bufferLabel.text = [NSString stringWithFormat:@"%lf", bufferTime];
    }];
    
    [self.view addSubview:self.playerManager.view];
    [self.playerManager.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.mas_width); // 188.f * 1280.f / 720
        make.top.mas_equalTo(288.f);
        make.centerX.mas_equalTo(0.f);
        make.height.mas_equalTo(188.f);
    }];

}

@end
