//
//  JJPlayerManager.h
//  JJPlayer
//
//  Created by 朱献国 on 2019/6/5.
//  Copyright © 2019 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "JJPlayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface JJPlayerManager : NSObject <JJPlayerMediaPlayAble>

@property (nonatomic, strong, readonly) AVURLAsset *asset;
@property (nonatomic, strong, readonly) AVPlayer *player;

@end

NS_ASSUME_NONNULL_END
