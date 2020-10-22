//
//  InputStreamUploadController.m
//  Network
//
//  Created by 朱献国 on 2020/10/22.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "InputStreamUploadController.h"

@interface InputStreamUploadController ()<NSURLSessionDelegate>

@end

#define UploadImageURL @"http://www.8pmedu.com/themes/jianmo/img/upload.php"

@implementation InputStreamUploadController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorRandomColor;
    
    [self inputStream];
}

- (void)inputStream {
    
    NSString *bodyStr = @"versions_id=1&system_type=1";
    NSInputStream *inputsteam = [[NSInputStream alloc] initWithData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    [inputsteam open];
    
    uint8_t buffer[256];
    memset(buffer, 0, 256);// 清空该段内存
    [inputsteam read:buffer maxLength:9];
    NSLog(@"++++%s", buffer);
    
    memset(buffer, 0, 256);// 清空该段内存
    [inputsteam read:buffer maxLength:3];
    NSLog(@"----%s", buffer);
    [inputsteam close];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self uploadImage];
}

- (void)uploadImage {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:UploadImageURL]];
    // 配置请求头和请求体
    NSString *bounary = @"******"; // 分界线
    // 一 配置请求头
    [request setValue:[NSString stringWithFormat:@"multipart/form-data;charset=utf-8;boundary=%@", bounary]  forHTTPHeaderField:@"Content-Type"];
    // 二 配置请求体
    NSMutableData *bodyData = [NSMutableData data];
    // 1 开始边界
    NSString *beginBoundary = [NSString stringWithFormat:@"--%@\r\n", bounary];
    [bodyData appendData:[beginBoundary dataUsingEncoding:NSUTF8StringEncoding]];
    // 2 属性 name和服务的name要匹配，相当于获取服务图片的key
    //  filename 服务器图片文件命名
    NSString *serverFileKey = @"image";
    NSString *serverFileName = @"101.png";
    NSString *serverContentTypes = @"image/png";
    
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"%@\" \r\n", serverFileKey, serverFileName];
    [string appendFormat:@"Content-Type: %@\r\n", serverContentTypes];
    [string appendFormat:@"\r\n"];
    [bodyData appendData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 3 文件数据
    UIImage *image = [UIImage imageNamed:@"1"];
    NSData *imageData = UIImagePNGRepresentation(image);
    [bodyData appendData:imageData];
    
    // 4 结束边界
    NSString *endBoundary = [NSString stringWithFormat:@"\r\n--%@", bounary];
    [bodyData appendData:[endBoundary dataUsingEncoding:NSUTF8StringEncoding]];
    
     NSInputStream *inputsteam = [[NSInputStream alloc] initWithData:bodyData];
     [request setHTTPBodyStream:inputsteam]; // 请求的时候，系统底层会对NSInputStream执行read操作
     
     NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
     
     NSURLSessionTask *task = [session dataTaskWithRequest:request];
     [task resume];
}

#pragma mark - NSURLSessionDelegate
// 进度
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{
    NSLog(@"didSendBodyData:: %lld--%lld--%lld", bytesSent, totalBytesSent, totalBytesExpectedToSend);
}

// 完成
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"over %@", error);
}

@end
