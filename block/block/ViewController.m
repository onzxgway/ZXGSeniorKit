//
//  ViewController.m
//  block
//
//  Created by 朱献国 on 2020/10/8.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "NSBlockFirstViewController.h"
#import "BlockMemoryViewController.h"
#import "BlockStructureViewController.h"
#import "BlockCycleRefrenceViewController.h"
#import "DemoViewController.h"

@interface ViewController ()

@property(nonatomic, strong)NSArray *titleArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"block";
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (int i=0; i<self.titleArr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(100.f, 100.f+100.f*i, 200.f, 50.f);
        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256.f)/255.f green:arc4random_uniform(256.f)/255.f blue:arc4random_uniform(256.f)/255.f alpha:1.f];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [btn setAccessibilityValue:[NSString stringWithFormat:@"%d", i]];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
    
}

#pragma mark - btn Action method
- (void)btnAction:(UIButton *)btn {
    
    int index = btn.accessibilityValue.intValue;
    switch (index) {
        case 0: {
        
            DemoViewController *blockFirstViewController = [[DemoViewController alloc] init];
            [self.navigationController pushViewController:blockFirstViewController animated:true];
        
        }
            break;
        case 1: {
            
            BlockMemoryViewController *viewCtrl = [[BlockMemoryViewController alloc] init];
            [self.navigationController pushViewController:viewCtrl animated:YES];
            
        }
            break;
        case 2: {
            
            BlockStructureViewController *viewCtrl = [[BlockStructureViewController alloc] init];
            [self.navigationController pushViewController:viewCtrl animated:YES];
            
        }
            break;
        case 3: {
            
            BlockCycleRefrenceViewController *viewCtrl = [[BlockCycleRefrenceViewController alloc] init];
            [self.navigationController pushViewController:viewCtrl animated:YES];
            
        }
            
            break;
        default:
            break;
    }
    
    
    
}

#pragma mark - getter method
- (NSArray *)titleArr {
    
    if (!_titleArr) {
        
        _titleArr = @[@"block", @"block copy strong weak", @"block结构分析", @"block循环引用"];
        
    }
    
    return _titleArr;
}

@end
