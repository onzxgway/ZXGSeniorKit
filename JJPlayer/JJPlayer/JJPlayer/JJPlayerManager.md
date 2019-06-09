####  JJPlayerManager实现思路：

    1.实例化的过程，就是初始化一些属性的默认值而已。（例如 是否自动播放属性为YES）

    2.给实例的assetURL属性赋值的时候，会做好播放准备。
        （
          1.根据url实例化播放器。
          2.播放画面添加到view上。
          3.AVPlayer和AVPlayerItem添加监听。
             *：AVPlayer的视频总时长和当前播放时间的监听。
             *：AVPlayerItem的loadedTimeRanges缓冲时长、status资源准备状态、playbackBufferEmpty播放已消耗所有缓冲媒体、placbackLikeylyToKeepUp已有缓冲是否可能在不停顿的情况下播放、presentationSize画面尺寸。
             
             *：AVPlayerItem的AVPlayerItemDidPlayToEndTimeNotification
          ）

    3.如果实例的shouldAutoPlay属性值为YES时，会直接播放。如果为NO，需要手动调用play方法。


####  JJPlayerManager注意点：

    1.AVPlayerItem和AVPlayer都有status属性，而且都可以使用KVO监听的。
        AVPlayerItem枚举类型如下：
        typedef NS_ENUM(NSInteger, AVPlayerItemStatus) {
            AVPlayerItemStatusUnknown,
            AVPlayerItemStatusReadyToPlay,
            AVPlayerItemStatusFailed
        };  
        而AVPlayer枚举类型如下：
        typedef NS_ENUM(NSInteger, AVPlayerStatus) {
            AVPlayerStatusUnknown,
            AVPlayerStatusReadyToPlay,
            AVPlayerStatusFailed
        };
        AVPlayerItemStatus代表当前播放资源的状态，
        AVPlayerStatus代表当前播放器的状态。

        注意：项目中遇到一个问题就是AVPlayer的status 为AVPlayerStatusReadyToPlay，但是视频就是播放不成功，后来将KVO的监听换成了AVPlayerItem，返回了AVPlayerItemStatusFailed。
        所以项目中最好使用item的status会准确点。


    2. 通过playbackBufferEmpty、placbackLikeylyToKeepUp监听实现的视频因网速卡顿的处理。
