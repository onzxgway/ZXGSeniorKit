# ruby语法
# CocoaPods为多个 具备多个target的project  添加依赖库
platform :ios, '9.0'
workspace 'ZXGSeniorKit.xcworkspace'

def totalPods
    pod 'ZXGCommontKit', :path => '../ZXGCommontKit'
#    pod 'YYKit', '~> 1.0.9'
#    pod 'MJExtension'
end

# target数组 如果有新的target直接加入该数组
Runtime = ['RuntimeOverview', 'RuntimeApplyScene']
Runtime.each do |t|
    target t do
        project 'Runtime/Runtime.project'
        totalPods
        #pod 'AFNetworking', '~> 3.0'
        #pod 'NJKWebViewProgress'
        #pod 'MJRefresh'
        #pod 'MLeaksFinder'
    end
end


# target数组 如果有新的target直接加入该数组
Thread = ['NSThread', 'NSOperation', 'GCD']
Thread.each do |t|
    target t do
        project 'Thread/Thread.project'
        totalPods
        #pod 'AFNetworking', '~> 3.0'
        #pod 'NJKWebViewProgress'
        #pod 'MJRefresh'
        #pod 'MLeaksFinder'
    end
end


# target数组 如果有新的target直接加入该数组
JJPlayer = ['JJPlayer']
JJPlayer.each do |t|
    target t do
        project 'JJPlayer/JJPlayer.project'
        totalPods
        #pod 'AFNetworking', '~> 3.0'
        #pod 'NJKWebViewProgress'
        #pod 'MJRefresh'
        #pod 'MLeaksFinder'
    end
end


# target数组 如果有新的target直接加入该数组
Architecture = ['MVCS']
Architecture.each do |t|
    target t do
        project 'Architecture/Architecture.project'
        totalPods
        #pod 'AFNetworking', '~> 3.0'
        #pod 'NJKWebViewProgress'
        #pod 'MJRefresh'
        #pod 'MLeaksFinder'
    end
end

# target数组 如果有新的target直接加入该数组
Swift = ['U17_Demo']
Swift.each do |t|
    target t do
        project 'Swift/Swift.project'
        totalPods
        #pod 'AFNetworking', '~> 3.0'
        #pod 'NJKWebViewProgress'
        #pod 'MJRefresh'
        #pod 'MLeaksFinder'
    end
end

# target数组 如果有新的target直接加入该数组
Runtime = ['NSURLSession', 'CTMNetwork']
Runtime.each do |t|
    target t do
        project 'Network/Network.project'
        totalPods
        pod 'AFNetworking', '~> 3.0'
        #pod 'NJKWebViewProgress'
        #pod 'MJRefresh'
        #pod 'MLeaksFinder'
    end
end

# target数组 如果有新的target直接加入该数组
Runtime = ['interview1']
Runtime.each do |t|
    target t do
        project 'interview1/interview1.project'
        totalPods
#        pod 'AFNetworking', '~> 3.0'
        #pod 'NJKWebViewProgress'
        #pod 'MJRefresh'
        #pod 'MLeaksFinder'
    end
end

# target数组 如果有新的target直接加入该数组
Runtime = ['Algorithm']
Runtime.each do |t|
    target t do
        project 'Algorithm/Algorithm.project'
        totalPods
#        pod 'AFNetworking', '~> 3.0'
        #pod 'NJKWebViewProgress'
        #pod 'MJRefresh'
        #pod 'MLeaksFinder'
    end
end
