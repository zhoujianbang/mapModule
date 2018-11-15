
Pod::Spec.new do |s|


  s.name         = "react-native-map-module"
  s.version      = "0.0.1"
  s.summary      = "A short description of react-native-map-module."

  s.homepage     = "https://github.com/zhoujianbang/mapModule.git"
  s.license      = "MIT"

  s.author             = { "zhoujianbang" => "zhoujianbang@meicai.cn" }
  
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/zhoujianbang/mapModule.git", :tag => "#{s.version}" }

  s.source_files  = "ios", "ios/**/*.{h,m}"
  s.exclude_files = "ios/Vender/**/*.{h,m}"

  s.requires_arc = true

  s.dependency "BaiduMapKit"
  s.dependency "BMKLocationKit"  

end
