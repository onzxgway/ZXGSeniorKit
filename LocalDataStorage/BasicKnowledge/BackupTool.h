//
//  BackupTool.h
//  BasicKnowledge
//
//  Created by 朱献国 on 2019/12/2.
//  Copyright © 2019 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BackupTool : NSObject


/// 对指定路径的文件做非备份设置
/// @param URL 文件的路径
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

@end

NS_ASSUME_NONNULL_END
