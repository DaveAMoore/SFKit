Pod::Spec.new do |s|
    s.name         = "SFKit"
    s.version      = "1.7.15"
    s.summary      = "User interface design overlay for UIKit."
    s.homepage     = "https://github.com/DaveAMoore/SFKit"
    s.license      = ""
    s.author       = { "David Moore" => "mooredev@me.com" }
    s.source       = { :git => "https://github.com/DaveAMoore/SFKit.git", :tag => "v1.7.15" }
    
    s.requires_arc = true
    s.swift_version = "4.2"
    s.module_map = "SFKit/Supporting Files/module.modulemap"
    s.pod_target_xcconfig = { "DEFINES_MODULE" => "YES",
                              "APPLICATION_EXTENSION_API_ONLY" => "YES" }
    s.frameworks   = "UIKit", "Foundation"
    s.ios.deployment_target = "10.0"

    s.preserve_path = "SFKit/Supporting Files/module.modulemap"
    s.source_files = "SFKit/*.{h,m,swift}", "SFKit/**/*.{h,m,swift}"
    s.public_header_files = "SFKit/Source/Appearance/*.h", "SFKit/Source/Appearance/**/*.h", "SFKit/Source/Charts/Pie/SFPieChartView.h", "SFKit/Source/Charts/Graphs/SFBarGraphChartView.h", "SFKit/Source/Charts/Graphs/SFChartTypes.h", "SFKit/Source/Charts/Graphs/SFDiscreteGraphChartView.h", "SFKit/Source/Charts/Graphs/SFGraphChartView.h", "SFKit/Source/Charts/Graphs/SFLineGraphChartView.h", "SFKit/Source/Charts/Miscellaneous/Definitions/SFDefines.h"
    s.private_header_files = "SFKit/Source/Charts/Pie/SFPieChartView_Internal.h", "SFKit/Source/Charts/Graphs/SFGraphChartView_Internal.h", "SFKit/Source/Charts/Pie/Components/*.h", "SFKit/Source/Charts/Graphs/Components/*.h", "SFKit/Source/Charts/Miscellaneous/*.h", "SFKit/Source/Charts/Miscellaneous/Definitions/SFTypes.h", "SFKit/Source/Charts/Miscellaneous/Definitions/SFErrors.h"
end

