# TengShiLive_iOS
##### 腾视 SDK iOS

### 开发环境要求
Xcode
iOS 12.0 以上的 iPhone 或者 iPad 真机。

### [GitHub下载](https://github.com/TengShiSource/TengShiLive_iOS.git)

### 集成 TengShiLive_iOS SDK
您可以选择使用 CocoaPods 自动加载的方式，或者先下载 SDK 再将其导入到您当前的工程项目中。

#### CocoaPods

##### 1.安装 CocoaPods

建议使用[Homebrew](https://brew.sh/index_zh-cn)进行安装

安装后
```
brew install CocoaPods
```

##### 2. 创建 Podfile 文件
进入项目所在路径，输入以下命令行之后项目路径下会出现一个 Podfile 文件。
```
pod init
```

##### 3. 编辑 Podfile 文件
编辑 Podfile 文件，并根据需要选择合适的 SDK 版本：
```
platform :ios, '12.0'

target 'target名称' do
  pod 'TengShiLive_iOS'
end
```
##### 4. 更新并安装 SDK
在终端窗口中输入如下命令以更新本地库文件，并安装 SDK：
```
pod install
```
或使用以下命令更新本地库版本：
```
pod update
```
pod 命令执行完后，会生成集成了 SDK 的 .xcworkspace 后缀的工程文件，双击打开即可。

##### 设置应用ID（`APPID`）、应用秘钥（`APPSecret`）
在[控制台](http://tengshilive.com/#/application)申请后在`APPHeadFile.swift`中填入

```
/// APP_KEY
let APP_KEY:String = "RMGF2JD1UY"

/// APP_SECRET
let APP_SECRET:String = "8OCFTPB1F7"
```

### 授权摄像头和麦克风使用权限
使用 SDK 的音视频功能，需要授权麦克风和摄像头的使用权限。在 App 的 Info.plist 中添加以下两项，分别对应麦克风和摄像头在系统弹出授权对话框时的提示信息。

>Privacy - Microphone Usage Description，并填入麦克风使用目的提示语。

>Privacy - Camera Usage Description，并填入摄像头使用目的提示语。

### 在 Objective-C 或 Swift 代码中使用 SDK
>swift引用：
```
import TengShiLive_iOS
```

>Objective-C引用
```
#import <TengShiLive_iOS/TengShiLive_iOS.h>
```
