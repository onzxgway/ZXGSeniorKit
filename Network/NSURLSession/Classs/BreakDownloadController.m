//
//  BreakDownloadController.m
//  Network
//
//  Created by 朱献国 on 2020/10/19.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "BreakDownloadController.h"

// 断点下载
@interface BreakDownloadController ()<NSURLSessionTaskDelegate>

@end

static NSString *const ImageURL = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603118011167&di=fd9df24b9d887970aed9a6ec147d40da&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1209%2F05%2Fc0%2F13630426_1346827472062.jpg";

@implementation BreakDownloadController {
    NSString *_filePathDocument;
    NSOutputStream *_outputStream;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorRandomColor;
    self.navigationItem.title = @"断点下载";
    
    NSString *fileName = @"smile";
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _filePathDocument = [filePath stringByAppendingPathComponent:fileName];
    _outputStream = [[NSOutputStream alloc] initToFileAtPath:_filePathDocument append:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self loadImage];
}

- (void)loadImage {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ImageURL]];
    request.HTTPMethod = @"GET";
    NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:_filePathDocument error:nil];
    long filesize = [[fileInfo objectForKey:NSFileSize] longValue];
    [request setValue:[NSString stringWithFormat:@"bytes=%ld-", filesize] forHTTPHeaderField:@"Range"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    [task resume];
}

#pragma mark - NSURLSessionDelegate
// 响应头包含网络数据的属性（下载的总数据大小 content-Length, Content-Type）
// 响应的过滤
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    [_outputStream open];
    completionHandler(NSURLSessionResponseAllow);
}

// 数据接收
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    [_outputStream write:[data bytes] maxLength:data.length];
}

// 完成
- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    [_outputStream close];
}

@end
