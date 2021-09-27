#
#  Be sure to run `pod spec lint TengShiLive_iOS.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

     spec.name         = "TengShiLive_iOS"
     spec.version      = "0.0.4"
     spec.summary      = "腾视 iOS SDK"

  #  This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
     spec.description  = <<-DESC
      腾视 iOS SDK 接入直播
                   DESC

     spec.homepage     = "https://github.com/TengShiSource/TengShiLive_iOS"
  #  spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  #  spec.license      = "MIT (example)"
     spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

    spec.author             = { "TengShiSource" => "377278982@qq.com" }
  # Or just: spec.author    = "TengShiSource"
  # spec.authors            = { "TengShiSource" => "377278982@qq.com" }
  # spec.social_media_url   = "https://twitter.com/TengShiSource"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

   spec.platform     = :ios
  # spec.platform     = :ios, "12.0"

  #  When using multiple platforms
    spec.ios.deployment_target = "12.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

     spec.source       = { :git => "https://github.com/TengShiSource/TengShiLive_iOS.git", :tag => spec.version }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  # spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  # spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

    spec.resource  = "TengShiFrameworkFile/QMResource.bundle"
  # spec.resources = "Resources/*.png"
  

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
    spec.frameworks = "UIKit","Foundation","AVFoundation","Accelerate"
    spec.ios.vendored_frameworks = "TengShiFrameworkFile/TengShiLive_iOS.framework"

  # spec.library   = "c++"
  # spec.libraries = "c++.tbd", "resolv.tbd"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.swift_version = "5.0"
    spec.swift_versions = ['5.0', '5.1', '5.2', '5.3', '5.4', '5.5']
    
    spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

  # 网络请求 Alamofire
     spec.dependency "Alamofire", "~> 5.4.3.0"
  # 自动布局 SnapKit
     spec.dependency "SnapKit", "~> 5.0.1.0"
  # 图片加载（OC）
     spec.dependency "SDWebImage", "~> 5.11.1.0"
  # 分段选择器
     spec.dependency "CSSegmentedControl", "~> 1.1.0"
  # 活动指示器 SVProgressHUD
     spec.dependency "SVProgressHUD", "~> 2.2.5.0"
  # 图片选取
     spec.dependency  "ZLPhotoBrowser", "~> 4.1.8.0"
  # 计时器 Schedule
     spec.dependency  "Schedule", "~> 2.1.0.0"
  # 加密解密
    spec.dependency  "CryptoSwift", "~> 1.4.1.0"
  #  腾讯白板 TIW（不支持Bitcode）
    spec.dependency  'TEduBoard_iOS', '~> 2.6.3.45.0'
  #  腾讯 IM
    spec.dependency  'TXIMSDK_iOS', '~> 5.1.62.0'
  #  腾讯实时音视频 TRTC
    spec.dependency  'TXLiteAVSDK_Professional', '~> 9.0.10433.0'
    spec.dependency  'TIWLogger_iOS', '~> 1.0.1.28.0'

end
