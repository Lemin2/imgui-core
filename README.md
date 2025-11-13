# ImGui Core - ESP-IDF Component

这个仓库包含了 [Dear ImGui](https://github.com/ocornut/imgui) 的核心文件，打包成 ESP-IDF 组件。它会自动跟踪并更新到最新的 ImGui 版本，只保留 ESP32 项目所需的核心源文件。

This repository contains the core files of [Dear ImGui](https://github.com/ocornut/imgui) packaged as an ESP-IDF component. It automatically tracks and updates to the latest ImGui releases, keeping only the essential source files needed for ESP32 projects.

## 包含的内容 / What's Included

本组件包含：
- ImGui 核心源文件（`.cpp` 和 `.h` 文件）
- `misc/` 文件夹，包含额外的实用工具
- ESP-IDF 组件配置文件

This component includes:
- Core ImGui source files (`.cpp` and `.h` files)
- `misc/` folder with additional utilities
- ESP-IDF component configuration files

**已排除**的内容（保持组件轻量化）：
- `backends/` - 平台特定的后端（你可以单独添加所需的后端）
- `docs/` - 文档（请参考官方 ImGui 仓库）
- `examples/` - 示例项目（请参考官方 ImGui 仓库）

**Excluded** (to keep the component lightweight):
- `backends/` - Platform-specific backends (you can add what you need separately)
- `docs/` - Documentation (refer to the official ImGui repository)
- `examples/` - Example projects (refer to the official ImGui repository)

## 安装 / Installation

### 使用 ESP-IDF 组件管理器 / Using ESP-IDF Component Manager

在项目的 `idf_component.yml` 中添加此组件：

Add this component to your project's `idf_component.yml`:

```yaml
dependencies:
  imgui-core:
    git: https://github.com/Lemin2/imgui-core.git
```

要使用特定版本，可以指定版本标签：

To use a specific version, you can specify a version tag:

```yaml
dependencies:
  imgui-core:
    git: https://github.com/Lemin2/imgui-core.git
    version: v1.92.4
```

### 手动安装 / Manual Installation

将此仓库克隆到项目的 `components` 目录：

Clone this repository into your project's `components` directory:

```bash
cd your-project/components
git clone https://github.com/Lemin2/imgui-core.git
```

## 使用方法 / Usage

在代码中包含 ImGui 头文件：

Include ImGui headers in your code:

```cpp
#include "imgui.h"
```

你需要为 ESP32 提供自己的后端实现（显示和输入处理）。

You'll need to provide your own backend implementation for ESP32 (display and input handling).

## 自动更新 / Automatic Updates

此仓库每天自动检查新的 ImGui 版本并更新核心文件。当发现新版本时，自动化工作流会：
1. 下载并更新源文件
2. 提交更改
3. 创建对应的 git 标签（如 `v1.92.4`）
4. 创建 GitHub Release

你也可以通过 GitHub Actions 手动触发更新。

This repository automatically checks for new ImGui releases daily and updates the core files. When a new version is found, the automation workflow will:
1. Download and update source files
2. Commit the changes
3. Create a corresponding git tag (e.g., `v1.92.4`)
4. Create a GitHub Release

You can also manually trigger an update via GitHub Actions.

### 手动更新 / Manual Update

你也可以使用提供的脚本手动更新 ImGui：

You can also manually update ImGui using the provided script:

```bash
# 更新到最新版本 / Update to latest version
./update_imgui.sh

# 更新到特定版本 / Update to specific version
./update_imgui.sh v1.90.0
```

## ImGui 版本 / ImGui Version

当前的 ImGui 版本存储在 `IMGUI_VERSION` 文件中。

The current ImGui version is stored in the `IMGUI_VERSION` file.

## 构建配置 / Build Configuration

本组件包含以下核心源文件：
- `imgui.cpp` - 核心功能
- `imgui_demo.cpp` - 演示窗口
- `imgui_draw.cpp` - 绘图功能
- `imgui_tables.cpp` - 表格功能
- `imgui_widgets.cpp` - 小部件

This component includes the following core source files:
- `imgui.cpp` - Core functionality
- `imgui_demo.cpp` - Demo windows
- `imgui_draw.cpp` - Drawing functions
- `imgui_tables.cpp` - Tables functionality
- `imgui_widgets.cpp` - Widgets

## 许可证 / License

此组件包装器采用 MIT 许可证发布。ImGui 本身也是 MIT 许可证。详情请参见 LICENSE 文件。

This component wrapper is released under the MIT License. ImGui itself is also MIT licensed. See the LICENSE file for details.

## 致谢 / Credits

- [Dear ImGui](https://github.com/ocornut/imgui) 作者 Omar Cornut 及贡献者
- ESP-IDF 组件包装器作者 Lemin2

Credits:
- [Dear ImGui](https://github.com/ocornut/imgui) by Omar Cornut and contributors
- ESP-IDF component wrapper by Lemin2