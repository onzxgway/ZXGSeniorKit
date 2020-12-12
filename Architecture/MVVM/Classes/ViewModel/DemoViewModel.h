//
//  DemoViewModel.h
//  MVVM
//
//  Created by 朱献国 on 2020/12/9.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DemoViewModel;
@class MAnimalViewModel;

NS_ASSUME_NONNULL_BEGIN

@protocol MAnimalViewModelDelegate<NSObject>
- (void)viewModel:(DemoViewModel *)viewModel reloadRow:(NSInteger)row;
- (void)reloadDataWithViewModel:(DemoViewModel *)viewModel;
@end

@interface DemoViewModel : NSObject
@property (nonatomic,weak) id<MAnimalViewModelDelegate> delegate;

@property (nonatomic, copy, readonly) NSMutableArray<MAnimalViewModel *> *dataSource;

- (DemoViewModel *_Nullable)animalEntityWitIndexPath:(NSInteger)row;
- (void)deleteWithRow:(NSInteger)row;
- (void)reloadData;

@end


@interface MAnimalViewModel : NSObject

@property (nonatomic,assign) NSInteger identifier;
@property (nonatomic,strong) NSData *imageData;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *summary;

@end

NS_ASSUME_NONNULL_END
