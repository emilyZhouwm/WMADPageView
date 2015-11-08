
Pod::Spec.new do |s|

  s.name         = "xiaomeiADPage"
  s.version      = "0.1.0"
  s.summary      = "带点推拉效果的广告轮播效果"

  s.description  = <<-DESC
                   A longer description of xiaomeiADPage in Markdown format.

                   * 可无限循环
                   * 可拉伸放大
                   * 可外部加载网络图片
                   * 可设置页面指示位置和样式动效
                   DESC

  s.homepage     = "https://coding.net/u/emilyzhou/p/xiaomeiADPage/git"
  s.license      = "MIT"
  s.author       = { "EmilyZhou" => "scarlettzwm@gmail.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/emilyZhouwm/xiaomeiADPage.git", :tag => "0.1.0" }

  s.source_files  = "xiaomeiADPage/WMAdPageView/*.{h,m}"

  s.public_header_files = "xiaomeiADPage/WMAdPageView/*.h"

  #s.subspec "TAPageControl" do |ta|
  #    ta.source_files = "xiaomeiADPage/WMAdPageView/TAPageControl/*.{h,m}"
  #    ta.public_header_files = "xiaomeiADPage/WMAdPageView/TAPageControl/*.h"
  #end


  s.framework  = "UIKit"
  s.requires_arc = true
  s.dependency 'TAPageControl', '~> 0.2.0'

end
