//
//  UploadController.m
//  Network
//
//  Created by 朱献国 on 2020/10/19.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "UploadController.h"

#define UploadImageURL @"http://www.8pmedu.com/themes/jianmo/img/upload.php"

@interface UploadController ()<NSURLSessionDelegate>

@end

@implementation UploadController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorRandomColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self uploadImage];
}
/**
 AFN封装了原生网络，核心与原生网络请求流程一样。
 */

/**
 AFN上传图片的一个完整POST请求：
   请求头部分
                                POST /themes/jianmo/img/upload.php HTTP/1.1
                Host            www.8pmedu.com
                Content-Type    multipart/form-data; boundary=Boundary+B5E2625CEF6EC7F4
                Accept          * / *
                User-Agent      LearnAFN/1.0 (iPhone; iOS 12.1; Scale/2.00)
                Accept-Language en;q=1
                Content-Length  262453
                Accept-Encoding gzip, deflate
                Connection      keep-alive
   请求体部分
                --Boundary+B5E2625CEF6EC7F4
                Content-Disposition: form-data; name="image"
               
                PNG;��^3����)or�!�.st�n��x(+9'���...
                --Boundary+B5E2625CEF6EC7F4--
 */

/**
 AFN带参数上传图片的一个完整POST请求：
    请求头部分
                         POST /themes/jianmo/img/upload.php HTTP/1.1
         Host            www.8pmedu.com
         Content-Type    multipart/form-data; boundary=Boundary+28FBA24634750C95
         Accept          * / *
         User-Agent      LearnAFN/1.0 (iPhone; iOS 12.1; Scale/2.00)
         Accept-Language en;q=1
         Content-Length  262617
         Accept-Encoding gzip, deflate
         Connection      keep-alive
 请求体部分
         --Boundary+28FBA24634750C95
         Content-Disposition: form-data; name="kind"
 
         image
         --Boundary+28FBA24634750C95
         Content-Disposition: form-data; name="number"
 
         1
         --Boundary+28FBA24634750C95
         Content-Disposition: form-data; name="image"
 
         PNG;��^3����)or�!�.st�n��x(+9'���...
         --Boundary+28FBA24634750C95--
 */
/**
   原生网络请求流程：

   1.创建 NSURLRequest 实例。
   2.创建 NSURLSession 实例。
   3.创建 NSURLSessionTask 实例。
   4.NSURLSessionTask 实例 开始。
*/
/**
    请求体由三个部分组成：
        1.初始和结束边界 2.属性 3.文件数据
*/
// 文件上传
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
    // 2 属性 name和服务的name要匹配,相当于服务获取图片的key
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
    
    request.HTTPBody = bodyData;
    request.HTTPMethod = @"POST";
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    [task resume];
}

// 进度
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{
    
    NSLog(@"didSendBodyData:: %lld--%lld--%lld", bytesSent, totalBytesSent, totalBytesExpectedToSend);
}

// 完成
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"over");
}

@end
