//
//  DemoModel.m
//  MVVM
//
//  Created by 朱献国 on 2020/12/9.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "DemoModel.h"

@implementation DemoModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadDataSource];
    }
    return self;
}

- (NSArray *)loadJson {
    return @[@{@"url": @"xxxx", @"name": @"yyyy", @"summary": @"zzzzz"},
            @{@"url": @"2222", @"name": @"3333", @"summary": @"44444"},
            @{@"url": @"x3xx", @"name": @"y2yy", @"summary": @"zz2zz"}
            ];
}

- (void)loadDataSource {
    NSArray *array = [self loadJson];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *dictionary in array) {
        MAnimalModel *model = [[MAnimalModel alloc] init];
        model.identifier = [[NSDate date] timeIntervalSince1970];
        model.imageUrl = [dictionary objectForKey:@"url"];
        model.name = [dictionary objectForKey:@"name"];
        model.summary = [dictionary objectForKey:@"summary"];
        
        [mutableArray addObject:model];
    }
    
    _dataSource = mutableArray;
}

- (void)downloadImageWtihModel:(MAnimalModel *)animalModel {
    if (animalModel.isLoading || !animalModel.imageUrl || animalModel.imageUrl.length == 0) {
        return;
    }
    
    animalModel.isLoading = YES;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *imageURL = [NSURL URLWithString:animalModel.imageUrl];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        if (imageData) {
            animalModel.imageData = imageData;
        }
        NSLog(@"imageData = %@",imageData);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.delegate && [self.delegate respondsToSelector:@selector(animalShowImage:row:)]) {
                NSInteger row = [self.dataSource indexOfObject:animalModel];
                [self.delegate animalShowImage:animalModel row:row];
            }
        });
    });
}

@end


@implementation MAnimalModel

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
