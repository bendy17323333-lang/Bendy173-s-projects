# 零点相位 5.2.0：IPA 构建包

这是从 Swift Playgrounds `.swiftpm` 工程整理出的标准 Xcode iOS 构建包。

## 生成的 IPA 类型

构建结果为：

`PhaseZero-5.2.0-build9-unsigned.ipa`

它包含真实的 iPhoneOS ARM64 应用二进制，只是不预先绑定任何人的 Apple 开发证书。AltServer / AltStore 安装时会使用你的 Apple Account 重新签名。

## GitHub Actions 构建

1. 把本文件夹中的全部内容放到 GitHub 仓库根目录。
2. 打开仓库的 **Actions** 页面。
3. 选择 **Build unsigned IPA**。
4. 点击 **Run workflow**。
5. 构建结束后下载名为 **PhaseZero-iOS26-IPA** 的 Artifact。
6. 解压 Artifact，里面就是 `.ipa` 和完整的 Xcode 构建日志。

工作流使用 `macos-26` 和 Xcode 26，避免 iOS 26 Liquid Glass API 被旧 SDK 当成外星语。

## 在 Mac 本地构建

安装完整 Xcode 26 或更高版本，然后在终端进入本目录运行：

```bash
./Scripts/build_unsigned_ipa.sh
```

生成文件位于 `dist/`。

## AltServer 安装

Windows 上按住 **Shift** 点击系统托盘里的 AltServer 图标，选择 **Sideload .ipa…**，再选生成的 IPA。手机必须运行 iOS 26 或更高版本，并开启 Developer Mode。

## 已做的兼容修改

原 SwiftPM 工程使用 `Bundle.module` 读取内置 HTML。标准 Xcode App target 没有这个自动生成属性，因此现在按构建方式选择：

- SwiftPM / Swift Playgrounds：`Bundle.module`
- 标准 Xcode App：`Bundle.main`

游戏代码、HTML、图标、隐私清单和版本信息均保留。

## 为什么桌面图标名暂时是 Phase Zero

AltStore Classic 的官方错误说明指出，用非 ASCII 应用名注册 App ID 可能触发错误 3009。因此这个侧载构建把系统桌面名称和可执行文件名设为 `Phase Zero` / `PhaseZero`，但游戏内部中文界面、资源和标题不变。先让它可靠装上去，比让证书系统对四个汉字产生哲学危机更重要。
