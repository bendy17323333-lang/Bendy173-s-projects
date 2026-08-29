# 零点相位 · iPhone Phone Ready 5.2

V5.2 基于已恢复稳定的 Recovery 5.1.1 分支制作。工程此前虽然在 `Package.swift` 中声明支持 `.phone`，但主菜单、HUD 和弹窗主要只是把 iPad UI 压缩，属于“技术上能塞进去，视觉上像搬家现场”。本版加入真正独立的 iPhone 横屏界面。

## iPhone 专用界面

- 独立主菜单：英雄区与指挥面板按 iPhone 横屏比例重新布局。
- 灵动岛、刘海、圆角和 Home Indicator 安全区分别计算，不使用对称假设。
- 战斗 HUD 改为超薄顶栏，保留波次、生命、护盾、相位、同步、Style、Boss 和经验，不再占据大块战场。
- 浮动双摇杆缩小，只有触摸时出现；视觉尺寸更小，触摸区域仍覆盖左右半屏。
- 相位与冲刺按钮缩小并贴合安全区，不会压在灵动岛或 Home Indicator 上。
- 能力选择使用 iPhone 专用横向卡片，三张卡可同时进入视野；玻璃高光继续由陀螺仪驱动。
- 暂停和结算界面改成横向双栏，不再把平板卡片粗暴缩小。
- 性能 HUD 在手机上移到底部左侧并压缩为单行遥测。

## 手机性能预算

在 iPhone 上自动使用单独预算：

- 自适应内部倍率约 `1.26–1.32`，平板仍保持原有较高预算。
- 自适应粒子预算降至约 `60%`。
- 高刷手机仍优先请求 90 FPS，画质优先可请求屏幕上限。
- 原生全屏战斗特效在手机上自动缩放到约 `82%`。
- 新安装时触控 UI 默认透明度为 `48%`。
- 低电量和高温降载逻辑继续生效。

这些改动只减少装饰性开销，不会改变敌人、伤害、掉落或肉鸽规则。

## 工程信息

- Minimum OS：iOS / iPadOS 26
- Device Families：iPhone + iPad
- Orientation：Landscape Left + Landscape Right
- Bundle Identifier：`com.asher.phasezero.ios26phoneready520`
- Version：`5.2.0`
- Build：`9`

## 打开方式

1. 停止旧版 Swift Playground 预览。
2. 解压 `PhaseZero_iOS26_PhoneReady_v5_2.swiftpm.zip`。
3. 在 iPad 的 Swift Playground 中打开 `.swiftpm` 工程并运行，确认没有红色编译错误。
4. 同一工程构建到 iPhone 后会自动启用 iPhone 专用界面；在 iPad 上仍使用平板布局。

当前执行环境没有 Xcode、iOS 26 SDK 或 iPhone 模拟器。这里完成的是 Swift 语法解析、资源检查、JavaScript 检查和尺寸预算检查；最终 Apple SDK 类型检查与 iPhone 真机表现仍以你的设备为准。
