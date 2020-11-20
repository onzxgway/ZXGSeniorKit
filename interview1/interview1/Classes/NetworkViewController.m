//
//  NetworkViewController.m
//  interview1
//
//  Created by 朱献国 on 2020/11/14.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "NetworkViewController.h"

@interface NetworkViewController ()

@end

@implementation NetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", NSHomeDirectory());
}

# pragma mark - iOS应用的文件目录是什么？它的上一层是什么？
/*
 查看 LocalDataStorage project。
 
 /Users/zhuxianguo/Library/Developer/CoreSimulator/Devices/4FBABD79-1500-4ED7-80BF-101C48CE71DC/data/Containers/Data/Application/96228698-774B-4234-BF0B-F352BA828F86
 */

# pragma mark - AFNetworking是否支持IPv6？
/*
 AFNetworking是基于NSURLSession的封装，NSURLSession是支持IPv6的，所以说AFNetworking也是支持IPv6。
 
 扩展：IPv4和IPv6知识点。
 
 IPv4使用32位二进制地址方案，可以显示为四位十进制数（IPv4的十进制表示法，例：128.11.3.31），IPv4地址空间提供大约43亿个(2^32)地址。43亿个地址能被分配的只有37亿个地址，其他地址用于特定目的。

 随着互联网的发展，预计未使用的IPv4地址的数量最终会耗尽，因为连接到互联网的每台设备（包括计算机，智能手机和游戏机）都需要。
 
 IPv6使用128位二进制地址方案，可以显示为四位十进制数（IPv6十六进制地址表示法：FDEC:BA98:7654:3210:ADBF:BBFF:2922:FFFF）。冒号以16位十六进制字段的序列隔离条目。

 IPv6提供3.4 x （10的38次方）个IP地址。此版本的IP寻址旨在满足耗尽IP的需求，并为未来的互联网增长需求提供足够的地址。

 由于IPv4使用两级地址结构，其中地址空间的使用不足。这就是提出IPv6的原因，以克服IPv4的不足。IP地址的格式和长度随着数据包格式的变化而改变，协议也被修改。
*/

# pragma mark - http请求报文、响应报文结构？

/*
 
 一个HTTP请求报文由四个部分组成：请求行、请求头、空行、请求体。
 
 1.请求行
    请求行由请求方法字段、URL字段和HTTP协议版本字段组成，它们之间用空格分隔。比如
    GET https://www.xxx.com/data/info.html HTTP/1.1
 
 HTTP1.0对于每个连接都只能传送一个请求和响应，请求就会关闭，HTTP1.0没有Host字段;
 而HTTP1.1在同一个连接中可以传送多个请求和响应，多个请求可以重叠和同时进行，HTTP1.1必须有Host字段。
 
 2.请求头
    HTTP客户程序(例如浏览器)，向服务器发送请求的时候必须指明请求类型(一般是GET或者 POST)。如有必要，客户程序还可以选择发送其他的请求头。大多数请求头并不是必需的，但Content-Length除外。对于POST请求来说Content-Length必须出现。
 
 常见的请求头字段含义：
    Accept：浏览器可接受的MIME类型。
    Accept-Charset：浏览器可接受的字符集。
    Accept-Encoding：浏览器能够进行解码的数据编码方式，比如gzip。Servlet能够向支持gzip的浏览器返回经gzip编码的HTML页面。许多情形下这可以减少5到10倍的下载时间。
    Accept-Language：浏览器所希望的语言种类，当服务器能够提供一种以上的语言版本时要用到。
    Authorization：授权信息，通常出现在对服务器发送的WWW-Authenticate头的应答中。
    Content-Length：表示请求消息正文的长度。
    Host：客户机通过这个头告诉服务器，想访问的主机名。Host头域指定请求资源的Intenet主机和端口号，必须表示请求url的原始服务器或网关的位置。HTTP/1.1请求必须包含主机头域，否则系统会以400状态码返回。
    If-Modified-Since：客户机通过这个头告诉服务器，资源的缓存时间。只有当所请求的内容在指定的时间后又经过修改才返回它，否则返回304“Not Modified”应答。
    Referer：客户机通过这个头告诉服务器，它是从哪个资源来访问服务器的(防盗链)。包含一个URL，用户从该URL代表的页面出发访问当前请求的页面。
    User-Agent：User-Agent头域的内容包含发出请求的用户信息。浏览器类型，如果Servlet返回的内容与浏览器类型有关则该值非常有用。
    Cookie：客户机通过这个头可以向服务器带数据，这是最重要的请求头信息之一。
    Pragma：指定“no-cache”值表示服务器必须返回一个刷新后的文档，即使它是代理服务器而且已经有了页面的本地拷贝。
    From：请求发送者的email地址，由一些特殊的Web客户程序使用，浏览器不会用到它。
    Connection：处理完这次请求后是否断开连接还是继续保持连接。如果Servlet看到这里的值为“Keep- Alive”，或者看到请求使用的是HTTP 1.1(HTTP1.1默认进行持久连接)，它就可以利用持久连接的优点，当页面包含多个元素时(例如Applet，图片)，显著地减少下载所需要的时间。要实现这一点，Servlet需要在应答中发送一个Content-Length头，最简单的实现方法是：先把内容写入 ByteArrayOutputStream，然后在正式写出内容之前计算它的大小。
    Range：Range头域可以请求实体的一个或者多个子范围。例如，
    表示头500个字节：bytes=0-499
    表示第二个500字节：bytes=500-999
    表示最后500个字节：bytes=-500
    表示500字节以后的范围：bytes=500-
    第一个和最后一个字节：bytes=0-0,-1
    同时指定几个范围：bytes=500-600,601-999
    但是服务器可以忽略此请求头，如果无条件GET包含Range请求头，响应会以状态码206(PartialContent)返回而不是以200 (OK)。
    UA-Pixels，UA-Color，UA-OS，UA-CPU：由某些版本的IE浏览器所发送的非标准的请求头，表示屏幕大小、颜色深度、操作系统和CPU类型。
 
 通过一个空行，告诉服务器请求头部到此为止。
 
 3.请求体
 
    若方法字段是GET，则此项为空，没有数据
    若方法字段是POST,则通常来说此处放置的就是要提交的数据
 */

# pragma mark - TCP和UDP的区别?
/*
 1、连接方面区别
 TCP面向连接（如打电话要先拨号建立连接）。
 UDP是无连接的，即发送数据之前不需要建权立连接。
 
 2、安全方面的区别
 TCP提供可靠的服务，通过TCP连接传送的数据，无差错，不丢失，不重复，且按序到达。
 UDP尽最大努力交付，即不保证可靠交付。
 
 3、传输效率的区别
 TCP传输效率相对较低。
 UDP传输效率高，适用于对高速传输和实时性有较高的通信或广播通信。
 
 4、连接对象数量的区别
 TCP连接只能是点到点、一对一的。
 UDP支持一对一，一对多，多对一和多对多的交互通信。
 */

/*
 TCP三次握手过程：
第一次握手：建立连接时，客户端发送syn包（syn=j）到服务器，并进入SYN_SENT状态，等待服务器确认；SYN：同步序列编号（Synchronize Sequence Numbers）。

第二次握手：服务器收到syn包，必须确认客户的SYN（ack=j+1），同时自己也发送一个SYN包（syn=k），即SYN+ACK包，此时服务器进入SYN_RECV状态；

第三次握手：客户端收到服务器的SYN+ACK包，向服务器发送确认包ACK(ack=k+1），此包发送完毕，客户端和服务器进入ESTABLISHED（TCP连接成功）状态，完成三次握手。
*/

/*
 UDP解决丢包错误的方法。
*/

@end
