//
//  BackupTool.m
//  BasicKnowledge
//
//  Created by 朱献国 on 2019/12/2.
//  Copyright © 2019 朱献国. All rights reserved.
//

#import "BackupTool.h"
#import <sys/xattr.h>

@implementation BackupTool

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL*)URL {
    const char* filePath = [[URL path] fileSystemRepresentation];
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, XATTR_NOFOLLOW);
    return result == 0;
}

@end
