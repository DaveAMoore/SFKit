Pod::Spec.new do |s|
    s.name         = "SFKit"
    s.version      = "1.7.12"
    s.summary      = "User interface design overlay for UIKit."
    s.homepage     = "https://github.com/DaveAMoore/SFKit"
    s.license      = ""
    s.author       = { "David Moore" => "mooredev@me.com" }
    s.source       = { :git => "https://github.com/DaveAMoore/SFKit.git", :tag => "v1.7.12" }
    
    s.requires_arc = true
    s.frameworks   = "UIKit", "Foundation"
    
    s.ios.deployment_target = "10.0"
    
    s.source_files = "SFKit/*.{h,m}", "SFKit/**/*.{h,m}"
    s.private_header_files = "SFKit/Supporting Files/SFModelCheck.h", "SFKit/Source/Charts/Pie/SFPieChartView_Internal.h", "SFKit/Source/Charts/Pie/Components/*.h", "SFKit/Source/Charts/Graph/SFGraphChartView_Internal.h", "SFKit/Source/Charts/Graph/Components/*.h"
end

