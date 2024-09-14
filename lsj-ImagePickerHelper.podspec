#
# Be sure to run `pod lib lint lsj-ImagePickerHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'lsj-ImagePickerHelper'
  s.version          = '0.1.0'
  s.summary          = '满足项目单选视频图片的低要求，并规避一些系统 Api 问题，也可作为系统 Api 的基础使用 Demo'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '其实很多项目中常常用到图片视频单选时，且我们只有这简单的需求时，都找了相对庞大的多选库，而这些多选库又需要用户授权图片权限才能使用，这在用户体验上是非常不好的，我们完全可以使用系统的 UIImagePickerController 完成我们的单选工作，而且不需要用户授权相册所有图片、或限制访问权限，提高用户的使用感受以及安全感，该项目也可最为系统 api 的学习参考'

  s.homepage         = 'https://github.com/534016847@qq.com/lsj-ImagePickerHelper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '534016847@qq.com' => '534016847@qq.com' }
  s.source           = { :git => 'https://github.com/534016847@qq.com/lsj-ImagePickerHelper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'lsj-ImagePickerHelper/Classes/**/*'
  
  # s.resource_bundles = {
  #   'lsj-ImagePickerHelper' => ['lsj-ImagePickerHelper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
