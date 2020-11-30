#
# Be sure to run `pod lib lint LNTools_fyh.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'LNTools_fyh'
    s.version          = '1.1.3'
    s.summary          = 'xxx'
#    一些常用的view类扩展，封装MJRefresh，图片浏览器，HUD
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/diligencefu/LNTools_fyh'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { '付耀辉' => 'diligencefu@sina.com' }
    s.source           = { :git => 'https://github.com/diligencefu/LNTools_fyh.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '10.0'
    
    s.source_files = 'LNTools_fyh/Classes/**/*'
    
    
    # s.resource_bundles = {
    #   'LNTools_fyh' => ['LNTools_fyh/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'

    
    # 图片浏览器
    s.subspec 'LNImageBrowser' do |browser|
        browser.source_files = 'LNTools_fyh/LNImageBrowser/Classes/**/*'
        browser.dependency 'YYWebImage'
    end
    
    # 刷新
    s.subspec 'LNRefresh' do |refresh|
        refresh.source_files = 'LNTools_fyh/LNRefresh/Classes/**/*'
        refresh.dependency 'MJRefresh'
    end
    
    # UIView扩展
    s.subspec 'LNViewExtension' do |tool|
        tool.source_files = 'LNTools_fyh/LNViewExtension/Classes/**/*'
        tool.dependency 'Toast'
    end
    
    # UIView扩展
    s.subspec 'LNProgressHUD' do |hud|
        hud.source_files = 'LNTools_fyh/LNProgressHUD/Classes/**/*'
        hud.dependency 'MBProgressHUD'
        hud.resource_bundles = {
            'LNTools_fyh' => ['LNTools_fyh/LNProgressHUD/Assets/Images.xcassets']
        }
        
    end
    
    
end
