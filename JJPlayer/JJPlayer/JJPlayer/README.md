####  播放器创建过程
    urlstring -> AVURLAsset -> AVPlayerItem -> AVPlayer

    AVURLAsset: AVAsset的一个子类，根据URL进行实例化，实例化的对象包含了URL对应的视频资源的所有信息。
    
        // 播放视频只需一个url就能进行这样太不安全了，别人可以轻易的抓包盗链，为此我们需要为视频链接做一个请求头的认证，这个功能可以借助AVURLAsset完成。
        - (instancetype)URLAssetWithURL:(NSURL *)URL options:(nullable NSDictionary<NSString *, id> *)options;
        AVURLAssetPreferPreciseDurationAndTimingKey，这个key对应的value是一个布尔值，用来表明资源是否需要为时长的精确展示，以及随机时间内容的读取进行提前准备。
        除了这个苹果官方介绍的功能外，还可以设置请求头，这个算是隐藏功能了，因为苹果并没有明说这个功能，我是费了很大劲找到的。
        NSMutableDictionary *headers = [NSMutableDictionary dictionary];
        [headers setObject:@"yourHeader" forKey:@"User-Agent"];
        [AVURLAsset URLAssetWithURL:URL options:@{@"AVURLAssetHTTPHeaderFieldsKey" : headers}];

        补充:后来得知这个参数是非公开的API,但是经多人测试项目上线不受影响。
        
    AVPlayerItem:根据AVAsset进行实例化的，管理视频资源，提供播放的数据源。
    AVPlayer: 播放器对象，控制着播放、暂停、播放速度等。

####  播放器画面添加到View上

    AVPlayer -> AVPlayerLayer 或者 AVPlayerLayer.player = AVPlayer 
    
    AVPlayerLayer:负责显示视频,如果没有添加该类,只有声音没有画面
    注意：根据AVPlayerLayer.videoGravity属性设置播放画面填充模式。

####  播放相关方法
    play   播放
    pause  暂停
    setRate 更改播放速度 // 注意更改播放速度要在视频开始播放之后才会生效
    addPeriodicTimeObserverForInterval:queue:usingBlock: 添加时间监听
    removeTimeObserver: 移除时间监听
    seekToTime:toleranceBefore:toleranceAfter: completionHandler: 跳转到指定时间点

####  视频相关信息获取

    监听视频资源管理类AVPlayerItem实例对象：
    1.播放状态 status  (虽然实例化播放器之后，就可以直接调用play方法进行播放，但是更稳妥的方式是在回调收到AVPlayerItemStatusReadyToPlay时再进行播放)
    2.已缓冲时间 loadedTimeRange 
    3.播放已消耗了所有的缓冲，且播放将停止或结束 playbackBufferEmpty
    4.缓冲是否满足在不停顿的前提下播放 playbackLikelyToKeepUp

    5.视频总时长和当前播放时间，通过[AVPlayer addPeriodicTimeObserverForInterval:queue:usingBlock:]添加监听，记住使用完了要移除
    6.通知监听播放结束。

## 实际项目中遇到的问题

    1. 添加的监听(kvo、notification、[AVPlayer addPeriodicTimeObserverForInterval])结束的时候一定要移除掉。
    [AVPlaye addPeriodicTimeObserverForInterval:queue:usingBlock:] 文档中提到了 返回的对象要记录下来，结束的时候一定要移除掉，虽然不会奔溃，但是会占用大量内存。 
