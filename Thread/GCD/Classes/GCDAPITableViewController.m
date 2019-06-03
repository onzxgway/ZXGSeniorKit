//
//  GCDAPITableViewController.m
//  GCD
//
//  Created by 朱献国 on 2019/6/3.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "GCDAPITableViewController.h"
#import "GCDAPIViewController.h"
#import "GroupViewController.h"
#import "ApplyViewController.h"
#import "BarrierViewController.h"
#import "SemaphoreViewController.h"

@interface GCDAPITableViewController ()

@end

@implementation GCDAPITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrs =  @[
                   @{
                       @"title"   : @"GCD常用API",
                       @"children": @[
                               @{@"title"   : @"dispatch_group_t",
                                 @"children": @"",
                                 @"selector": @"dispatch_group"},
                               @{@"title"   : @"dispatch_semaphore_t",
                                 @"children": @"",
                                 @"selector": @"dispatch_semaphore"},
                               @{@"title"   : @"dispatch_barrier_async",
                                 @"children": @"",
                                 @"selector": @"dispatch_barrier_async"},
                               @{@"title"   : @"dispatch_set_target_queue",
                                 @"children": @"",
                                 @"selector": @"dispatch_set_target_queue"},
                               @{@"title"   : @"dispatch_after",
                                 @"children": @"",
                                 @"selector": @"dispatch_after"},
                               @{@"title"   : @"dispatch_once",
                                 @"children": @"",
                                 @"selector": @"dispatchOnce"},
                               @{@"title"   : @"dispatch_apply",
                                 @"children": @"",
                                 @"selector": @"dispatch_apply"},
                               @{@"title"   : @"dispatch_suspend/dispatchp_resume",
                                 @"children": @"",
                                 @"selector": @"dispatch_suspend"},
                               @{@"title"   : @"dispatch_queue_t激活",
                                 @"children": @"",
                                 @"selector": @"dispatch_queue_inactive"},
                               @{@"title"   : @"dispatch_async_f",
                                 @"children": @"",
                                 @"selector": @"dispatch_async_f"}
                               ]
                       }
                   ];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GCDAPIViewController *vc = [[GCDAPIViewController alloc] init];
    NSArray *arr = [self.arrs[indexPath.section] objectForKey:@"children"];
    vc.selectorStr = [arr[indexPath.row] objectForKey:@"selector"];
    
    if ([vc.selectorStr isEqualToString:@"dispatch_group"]) {
        [self.navigationController pushViewController:[GroupViewController new] animated:YES];
    }
    else if ([vc.selectorStr isEqualToString:@"dispatch_semaphore"]) {
        [self.navigationController pushViewController:[SemaphoreViewController new] animated:YES];
    }
    else if ([vc.selectorStr isEqualToString:@"dispatch_apply"]) {
        [self.navigationController pushViewController:[ApplyViewController new] animated:YES];
    }
    else if ([vc.selectorStr isEqualToString:@"dispatch_barrier_async"]) {
        [self.navigationController pushViewController:[BarrierViewController new] animated:YES];
    }
    else {
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
