#
# Be sure to run `pod lib lint WMXiaoMeiAdPageLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "WMXiaoMeiAdPageLib"
  s.version          = "0.1.0"
  s.summary          = “带点推拉效果的轮播，可放大可url”

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/emilyZhouwm/xiaomeiADPage"
  # s.screenshots     = "https://github.com/emilyZhouwm/xiaomeiADPage/blob/master/xiaomeiADPage.gif", "https://github.com/emilyZhouwm/xiaomeiADPage/blob/master/xmADPage.gif"
  s.license          = 'MIT'
  s.author           = { "emilyzhou" => "scarlettzwm@gmail.com" }
  s.source           = { :git => "https://github.com/emilyZhouwm/xiaomeiADPage.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://github.com/emilyZhouwm'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'xiaomeiADPage/*'
  s.resource_bundles = {
    'WMXiaoMeiAdPageLib' => ['xiaomeiADPage/*.png']
  }

  # s.public_header_files = 'xiaomeiADPage/*.h'
  # s.frameworks = 'UIKit'
end
