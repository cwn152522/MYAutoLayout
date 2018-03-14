Pod::Spec.new do |s|

  s.name         = "MYAutoLayout"
  s.version      = "1.0.0"
  s.summary      = "使用链式编程思想进行封装的自动布局库MYAutolayout."
  s.homepage     = "https://github.com/cwn152522/MYAutoLayout"
  s.license      = "MIT"
  s.author             = { "陈伟南" => "1014949353@qq.com" }
  s.platform     = :ios
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/cwn152522/MYAutoLayout.git", :tag => s.version }
  s.source_files  = "Classes", "MYAutoLayout/Classes/*.{h,m}"
  s.frameworks  = "UIKit"

end
