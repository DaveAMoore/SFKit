Pod::Spec.new do |s|
    s.name         = "SFKit"
    s.version      = "1.7.12"
    s.summary      = "User interface design overlay for UIKit."
    s.homepage     = "https://github.com/DaveAMoore/SFKit"
    s.license      = ""
    s.author       = { "David Moore" => "mooredev@me.com" }
    s.source       = { :git => "https://github.com/DaveAMoore/SFKit.git", :tag => "v1.7.12" }
    
    s.requires_arc = true
    s.pod_target_xcconfig = { "DEFINES_MODULE" => "YES",
                              "APPLICATION_EXTENSION_API_ONLY" => "YES",
                              "SWIFT_INCLUDE_PATHS" => "$(SRCROOT)/SFKit/Supporting\\ Files/Project\\ Module" }
    s.frameworks   = "UIKit", "Foundation"
    
    s.ios.deployment_target = "10.0"
    
    s.source_files = "SFKit/*.{h,m,swift}", "SFKit/**/*.{h,m,swift,modulemap}"
    s.private_header_files = "SFKit/Supporting Files/SFModelCheck.h", "SFKit/Source/Charts/Pie/SFPieChartView_Internal.h", "SFKit/Source/Charts/Pie/Components/*.h", "SFKit/Source/Charts/Graph/SFGraphChartView_Internal.h", "SFKit/Source/Charts/Graph/Components/*.h"
end

