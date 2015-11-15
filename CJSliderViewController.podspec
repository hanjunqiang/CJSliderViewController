Pod::Spec.new do |s|
  s.name         = "CJSliderViewController"
  s.version      = "1.0.41"
  s.summary      = "类似网易新闻的结构."
  s.homepage     = "https://github.com/dvlproad/CJSliderViewController"
  s.license      = "MIT"
  s.author             = "dvlproad"
  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/dvlproad/CJSliderViewController.git", :tag => "1.0.41" }
  s.source_files  = "CJSliderViewController/**/*.{h,m}"
  s.resources = "CJSliderViewController/**/*.{xib,png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  s.dependency 'RadioButtons', '~> 1.0.0'

end
