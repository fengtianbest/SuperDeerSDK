Pod::Spec.new do |spec|
spec.name         = "SuperDeerSDK"
spec.version      = "0.1.8"
spec.summary      = "commen UI class"
spec.description  = " UI Extension+Category and DataProcess"

spec.homepage     = "https://github.com/fengtianbest/SuperDeerSDK"
spec.license      =  "MIT"
spec.author             = { "liulei" => "270659112@qq.com" }
spec.platform     = :ios, "8.0"
spec.source       = { :git => "https://github.com/fengtianbest/SuperDeerSDK.git", :tag => "#{spec.version}" }
spec.source_files  = "**/*.{h,m}"
spec.frameworks   = 'UIKit'
spec.dependency "MJRefresh"
spec.dependency "Masonry"
spec.requires_arc = true
end
