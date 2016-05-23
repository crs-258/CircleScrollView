

Pod::Spec.new do |s|

  s.name         = "CircleScrollView"
  s.version      = "0.0.1"
  s.summary      = "A CircleScrollView used on iOS"
  s.description  = <<-DESC
  						a project provide a ad along to scroll of a library for iOS developer
                   DESC

  s.homepage     = "https://github.com/crs-258/CircleScrollView"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "陈荣山" => "294872802@qq.com" }
  # Or just: s.author    = "crs-258"

  s.platform     = :ios
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/crs-258/CircleScrollView.git", :tag => "0.0.1"}
  s.source_files  = "CircleScrollViewClass/*"

  s.requires_arc = true


  s.dependency "SDWebImage", "~> 3.7.2"
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

end

