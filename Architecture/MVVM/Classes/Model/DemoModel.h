//
//  DemoModel.h
//  MVVM
//
//  Created by 朱献国 on 2020/12/9.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MAnimalModel;

NS_ASSUME_NONNULL_BEGIN

@protocol MAnimalModelDelegate<NSObject>
- (void)animalShowImage:(MAnimalModel *)animalModel row:(NSInteger)row;
@end

@interface DemoModel : NSObject

@property (nonatomic, weak) id<MAnimalModelDelegate> delegate;
@property (nonatomic, strong) NSArray<MAnimalModel *> *dataSource;

- (void)downloadImageWtihModel:(MAnimalModel *)animalModel;

@end

@interface MAnimalModel : NSObject

@property (nonatomic) NSInteger identifier;
@property (nonatomic) NSData *imageData;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic) BOOL isLoading;

@end

NS_ASSUME_NONNULL_END
