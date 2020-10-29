//
//  DownloadController.m
//  Network
//
//  Created by 朱献国 on 2020/10/19.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "DownloadController.h"

// 普通下载
@interface DownloadController ()<NSURLSessionDownloadDelegate>

@end

static NSString *const ImageURL = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603118011167&di=fd9df24b9d887970aed9a6ec147d40da&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1209%2F05%2Fc0%2F13630426_1346827472062.jpg";

@implementation DownloadController {
    NSString *_fullPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"下载";
    
    NSString *fileName = @"smile.png"; // 文件名称 通过md5 生成一个唯一文件名
    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _fullPath = [docuPath stringByAppendingPathComponent:fileName];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self loadImage];
}

- (void)loadImage {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ImageURL]];
    request.HTTPMethod = @"GET";
    // ephemeralSessionConfiguration 不带缓存 defaultSessionConfiguration带缓存
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    // NSURLSessionDownloadTask把数据直接下载到沙盒下tmp目录中
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    [task resume];
}

#pragma mark - NSURLSessionDelegate
//1 响应头  这次网络数据的属性（下载的总数据大小 content-Length, Content-Type）
// 响应的过滤
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    completionHandler(NSURLSessionResponseAllow);
}

// 下载过程  下载的进度 接收数据回掉
// 下载的数据自动写入沙盒下tmp目录中，未下载完的文件会一直保存，下载完成的话，会自动从目录中移除。
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    // bytesWritten 当前包收到的数据 totalBytesWritten已经接受的数据 totalBytesExpectedToWrite总数据大小
    NSLog(@"当前包收到的数据:%lld", bytesWritten);
    NSLog(@"已经接收到的总数据:%lld", totalBytesWritten);
    NSLog(@"需接收的总数据:%lld", totalBytesExpectedToWrite);
    NSLog(@"===========================");
}

// 文件下载完成
// @param location 文件下载到沙盒下tmp目录中，系统会自动清洗
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSError *error = nil;
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:_fullPath] error:&error];
}

// 网络任务结束
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
}

@end
