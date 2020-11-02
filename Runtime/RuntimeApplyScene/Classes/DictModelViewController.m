//
//  DictModelViewController.m
//  RuntimeApplyScene
//
//  Created by 朱献国 on 2020/11/2.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "DictModelViewController.h"
#import "Status.h"
#import "NSObject+DictToModel.h"

@interface DictModelViewController ()

@end

@implementation DictModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dictToModelRuntime];
}

- (void)dictToModelRuntime {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"status" ofType:@"plist"];
    NSDictionary *datas = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *dicts = datas[@"statuses"];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSDictionary *tempDict in dicts) {
        Status *status = [Status deepModelWithDict:tempDict];
        [tempArr addObject:status];
    }
    NSLog(@"%@",tempArr);
}

@end
