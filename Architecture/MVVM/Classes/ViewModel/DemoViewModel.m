//
//  DemoViewModel.m
//  MVVM
//
//  Created by 朱献国 on 2020/12/9.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "DemoViewModel.h"
#import "DemoModel.h"

@interface DemoViewModel()<MAnimalModelDelegate>
@property (nonatomic,strong) DemoModel *animalsModel;
@end

@implementation DemoViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        // 视图模型层 与 模型层 建立关系
        _animalsModel = [[DemoModel alloc] init];
        _animalsModel.delegate = self;
        
        [self reloadData];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (MAnimalViewModel *)animalEntityWitIndexPath:(NSInteger)row {
    MAnimalViewModel *viewModel = [_dataSource objectAtIndex:row];
    
    if (_animalsModel.dataSource.count > row) {
        MAnimalModel *model = [_animalsModel.dataSource objectAtIndex:row];
        [_animalsModel downloadImageWtihModel:model];
    }
    
    return viewModel;
}

- (void)animalShowImage:(MAnimalModel *)animalModel row:(NSInteger)row {
    MAnimalViewModel *viewModel = [_dataSource objectAtIndex:row];
    viewModel.imageData = animalModel.imageData;
    
    if (_delegate && [_delegate respondsToSelector:@selector(viewModel:reloadRow:)]) {
        [_delegate viewModel:self reloadRow:row];
    }
}

- (void)deleteWithRow:(NSInteger)row {
    [_dataSource removeObjectAtIndex:row];
}

- (void)reloadData {
    MAnimalViewModel *vieweModel = nil;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (MAnimalViewModel *eachViewModel in _animalsModel.dataSource) {
        vieweModel = [[MAnimalViewModel alloc] init];
        vieweModel.identifier = eachViewModel.identifier;
        vieweModel.imageData = eachViewModel.imageData;
        vieweModel.name = eachViewModel.name;
        vieweModel.summary = eachViewModel.summary;
        [mutableArray addObject:vieweModel];
    }
    
    _dataSource = mutableArray;
    
    if (_delegate && [_delegate respondsToSelector:@selector(reloadDataWithViewModel:)]) {
        [_delegate reloadDataWithViewModel:self];
    }
}

@end


@implementation MAnimalViewModel

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
