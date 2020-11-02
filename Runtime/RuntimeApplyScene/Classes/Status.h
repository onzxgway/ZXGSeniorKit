//
//  Status.h
//  RuntimeApplyScene
//
//  Created by 朱献国 on 2020/11/2.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (copy,nonatomic)NSString *profile_image_url;
@property (assign,nonatomic)BOOL vip;
@property (copy,nonatomic)NSString *name;
@property (strong,nonatomic)NSNumber *mbrank;
@property (strong,nonatomic)NSNumber *mbtype;

@end


@interface Status : NSObject

@property (copy  , nonatomic) NSString      *source;
@property (copy  , nonatomic) NSString      *created_at;
@property (copy  , nonatomic) NSString      *idstr;
@property (copy  , nonatomic) NSString      *text;
@property (strong, nonatomic) NSNumber      *reposts_count;
@property (strong, nonatomic) NSArray       *pic_urls;
@property (strong, nonatomic) NSNumber      *attitudes_count;
@property (strong, nonatomic) NSNumber      *comments_count;
@property (strong, nonatomic) User          *user;
@property (strong, nonatomic) NSDictionary  *retweeted_status;

@end

NS_ASSUME_NONNULL_END
