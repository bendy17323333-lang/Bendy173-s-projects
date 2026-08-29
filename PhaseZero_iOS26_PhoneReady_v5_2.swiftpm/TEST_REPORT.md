# Phone Ready 5.2 静态检查报告

## 基线

本版从 Recovery 5.1.1 建立，没有重新引入 V5.1 中曾导致卡死的复杂 HUDStore、Path2D 渲染器和新帧调度闭环。

## 已完成检查

- `Package.swift` 通过 Swift 6.2.1 `swiftc -parse`。
- 工程内全部 Swift 源文件通过 `swiftc -parse`。
- 内置 HTML 的 JavaScript 通过 Node.js `--check`。
- `AppInfo.plist` 与 `PrivacyInfo.xcprivacy` 可正常解析。
- Asset Catalog 中全部 `Contents.json` 可正常解析。
- iPhone、iPad 设备族和左右横屏声明存在。
- 新增 iPhone 布局文件均由 SwiftPM target 自动纳入。

## 尺寸预算检查

使用下列典型横屏尺寸做静态布局预算：

| 测试画布 | 可用宽度 | 主菜单指挥区 | 三张能力卡 | HUD 所需宽度 |
|---|---:|---:|---:|---:|
| 667×375 | 653 | 456 | 586 | 385 |
| 812×375，左右安全区 44 | 716 | 476 | 662 | 457 |
| 874×402，左右安全区 59 | 748 | 498 | 662 | 457 |
| 956×440，左右安全区 62 | 824 | 553 | 662 | 457 |

所有测试中，主菜单、三张能力卡和 HUD 均在安全区后的可用宽度内。

## 仍需真机验证

当前环境没有 Apple SDK，因此以下内容只能由 Swift Playground / Xcode 真机确认：

- Liquid Glass 具体折射与层级合成。
- 灵动岛方向切换后的真实安全区数值。
- Core Motion 高光方向是否符合左右持机习惯。
- 触摸手势与系统边缘手势的冲突情况。
- 120 Hz iPhone 上实际帧率、温度和耗电。
- SwiftUI 类型检查以及 iOS 26 SDK 可用性诊断。

静态解析通过不等于 Apple SDK 编译通过。至少这次我们把“括号没有打歪”放回了它应有的位置，而不是拿来剪彩。
