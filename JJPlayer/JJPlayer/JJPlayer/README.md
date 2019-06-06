####  播放器创建过程
    urlstr -> AVURLAsset -> AVPlayerItem -> AVPlayer
    注意：一个链接对应一个AVPlayer实例，切换播放链接就是切换播放器。

####  播放器画面添加到UIView上
    AVPlayerLayer.player = AVPlayer 
    AVPlayerLayer添加到UIView.layer即可。
    注意：根据AVPlayerLayer.videoGravity属性设置播放画面填充模式。

####  播放器方法
    [AVPlayer play]   播放
    [AVPlayer pause]  暂停
    [AVPlayer addPeriodicTimeObserverForInterval:queue:usingBlock:] 添加时间监听
    [AVPlayer removeTimeObserver:]; 移除时间监听
    [AVPlayer seekToTime:toleranceBefore:toleranceAfter: completionHandler:]; 跳转到指定时间点



## 实际项目中遇到的问题

1. 添加的时间和播放结束监听一定要移除掉。
[AVPlaye addPeriodicTimeObserverForInterval:queue:usingBlock:] 文档中提到了 返回的对象要记录下来，结束的时候一定要移除掉，虽然不会奔溃，但是会占用大量内存。 
