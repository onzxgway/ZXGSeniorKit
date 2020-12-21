//
//  KVCViewController.m
//  KVOAndKVC
//
//  Created by 朱献国 on 2020/12/21.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "KVCViewController.h"

@interface KVCObject : NSObject

@end

@implementation KVCObject

//- (void)setKey:(id)key {
//    NSLog(@"%s", __func__);
//}

//- (void)_setKey:(id)key {
//    NSLog(@"%s", __func__);
//}

//- (void)setIsKey:(id)key {
//    NSLog(@"%s", __func__);
//}

// ===========

//- (id)getKey {
//    NSLog(@"%s", __func__);
//    return nil;
//}

//- (id)key {
//    NSLog(@"%s", __func__);
//    return nil;
//}

//- (id)isKey {
//    NSLog(@"%s", __func__);
//    return nil;
//}

- (id)_key {
    NSLog(@"%s", __func__);
    return nil;
}

@end





@interface KVCViewController ()

@end

@implementation KVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    KVCObject *obj = [[KVCObject alloc] init];
//    [obj setValue:@"value" forKey:@"key"];
    [obj valueForKey:@"key"];
}



@end

