# ruby语法
# CocoaPods为多个 具备多个target的project  添加依赖库
platform :ios, '9.0'
workspace 'ZXGSeniorKit.xcworkspace'

#def pods
#    pod 'ZXGCommontKit', :path => '../ZXGCommontKit'
#    pod 'YYKit', '~> 1.0.9'
#    pod 'MJExtension'
#    pod 'Masonry'
#end

# target数组 如果有新的target直接加入该数组
Runtime = ['RuntimeOverview']
Runtime.each do |t|
    target t do
        project 'Runtime/Runtime.project'
        #pods
        #pod 'AFNetworking', '~> 3.0'
        #pod 'NJKWebViewProgress'
        #pod 'MJRefresh'
        #pod 'MLeaksFinder'
    end
end