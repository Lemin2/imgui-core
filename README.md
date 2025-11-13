# ImGui Core - ESP-IDF Component

This repository contains the core files of [Dear ImGui](https://github.com/ocornut/imgui) packaged as an ESP-IDF component. It automatically tracks and updates to the latest ImGui releases, keeping only the essential source files needed for ESP32 projects.

## What's Included

This component includes:
- Core ImGui source files (`.cpp` and `.h` files)
- `misc/` folder with additional utilities
- ESP-IDF component configuration files

**Excluded** (to keep the component lightweight):
- `backends/` - Platform-specific backends (you can add what you need separately)
- `docs/` - Documentation (refer to the official ImGui repository)
- `examples/` - Example projects (refer to the official ImGui repository)

## Installation

### Using ESP-IDF Component Manager

Add this component to your project's `idf_component.yml`:

```yaml
dependencies:
  imgui-core:
    git: https://github.com/Lemin2/imgui-core.git
```

### Manual Installation

Clone this repository into your project's `components` directory:

```bash
cd your-project/components
git clone https://github.com/Lemin2/imgui-core.git
```

## Usage

Include ImGui headers in your code:

```cpp
#include "imgui.h"
```

You'll need to provide your own backend implementation for ESP32 (display and input handling).

## Automatic Updates

This repository automatically checks for new ImGui releases daily and updates the core files. You can also manually trigger an update via GitHub Actions.

## ImGui Version

The current ImGui version is stored in the `IMGUI_VERSION` file.

## License

This component wrapper is released under the MIT License. ImGui itself is also MIT licensed. See the LICENSE file for details.

## Credits

- [Dear ImGui](https://github.com/ocornut/imgui) by Omar Cornut and contributors
- ESP-IDF component wrapper by Lemin2