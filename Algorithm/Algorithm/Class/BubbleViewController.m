//
//  BubbleViewController.m
//  Algorithm
//
//  Created by 朱献国 on 2020/11/16.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "BubbleViewController.h"

@interface BubbleViewController ()

@end

@implementation BubbleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIWebView *wv = [[UIWebView alloc] init];
//    [wv stringByEvaluatingJavaScriptFromString:<#(nonnull NSString *)#>]
    
    const int maxCount = 1000;
    int a[maxCount] = {};
    for (int i = 0; i < maxCount; i ++) {
        a[i] = rand()%maxCount;
    }
    [self bubbleSort:a length:maxCount];
}

// 冒泡排序
- (void)bubbleSort:(int [])sortAry length:(int)length {
    BOOL needR = false;
    int count = length;
    // n个元素，需要n趟冒泡。
    for (int i = 0; i < count; count++) {
        needR = false;
        for (int j = 0; j <= count - 2 - i; j++) {
            if (sortAry[j] > sortAry[j + 1]) {
                [self swap:&sortAry[j] with:&sortAry[j + 1]];
            }
        }
        if (needR == false) {
            break;
        }
    }
}

- (void)swap:(int *)a with:(int *)b {
    int temp = *a;
    *a = *b;
    *b = temp;
}

// 二分查找
- (int)search:(int)b inArray:(int [])a start:(int)start end:(int)end {
    if (start == end) {
        if (a[start] == b) {
            return start;
        } else {
            return -1;
        }
    } else if (start > end) {
        return -1;
    }
    
    int middle = start + (end - start) / 2;
    if (a[middle] == b) {
        return middle;
    } else if (a[middle] > b) {
        return [self search:b inArray:a start:start end:middle-1];
    } else {
        return [self search:b inArray:a start:middle+1 end:end];
    }
}

// 快速排序
- (void)sortCArray:(int [])a start:(int)start end:(int)end {
    if (start >= end) {
        return;
    }
    int low = start;
    int high = end;
    int keyIndex = start;
    
    while (low < high) {
        // 从高往低找比key小的元素
        while (a[high] >= a[keyIndex] && high > keyIndex) {
            high --;
        }
        if (a[high] < a[keyIndex]) {
            [self swap:&a[high] with:&a[keyIndex]];
            keyIndex = high;
        }
        while (a[low] <= a[keyIndex] && low < keyIndex) {
            low ++;
        }
        if (a[low] > a[keyIndex]) {
            [self swap:&a[low] with:&a[keyIndex]];
            keyIndex = low;
        }
    }
    // 一趟快速排序结束，以key为，将数组分为前后两部分，分别排序
    if (low == high) {
        [self sortCArray:a start:start end:keyIndex-1];
        [self sortCArray:a start:keyIndex+1 end:end];
    }
}

// 插入排序
// 选择排序


// Objective-C语言
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    if ([[url scheme] isEqualToString:@"gap"]) {
    //在这里做JavaScript调Objective-C的事情
    // ....
    //做完,之后用如下方法调回JavaScript
        [webView stringByEvaluatingJavaScriptFromString:@"alert('done')"];
        return NO;
    }
    return YES;
}
     
     
@end
