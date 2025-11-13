# ImGui Core - ESP-IDF Component Project Structure

## Directory Structure

```
imgui-core/
├── .github/
│   └── workflows/
│       └── update-imgui.yml    # Automated update workflow
├── misc/                        # ImGui misc utilities (auto-updated)
├── CMakeLists.txt              # ESP-IDF component build configuration
├── idf_component.yml           # ESP-IDF component metadata
├── IMGUI_VERSION               # Current ImGui version tracking
├── LICENSE                     # MIT License
├── README.md                   # Project documentation (bilingual)
├── update_imgui.sh            # Manual update script
├── imgui.cpp                   # Core ImGui implementation (auto-updated)
├── imgui.h                     # Main ImGui header (auto-updated)
├── imgui_demo.cpp             # Demo windows (auto-updated)
├── imgui_draw.cpp             # Drawing functions (auto-updated)
├── imgui_internal.h           # Internal header (auto-updated)
├── imgui_tables.cpp           # Tables implementation (auto-updated)
├── imgui_widgets.cpp          # Widgets implementation (auto-updated)
└── imconfig.h                 # Configuration header (auto-updated)
```

## Files Managed by Automation

The following files are automatically updated when a new ImGui release is detected:

### Core Source Files
- `imgui.cpp` - Main ImGui implementation
- `imgui_demo.cpp` - Demo windows and examples
- `imgui_draw.cpp` - Drawing and rendering functions
- `imgui_tables.cpp` - Tables API implementation
- `imgui_widgets.cpp` - Standard widgets implementation

### Header Files
- `imgui.h` - Main public API
- `imgui_internal.h` - Internal structures and helpers
- `imconfig.h` - Compile-time configuration
- `imstl.h` - STL helpers (if present)

### Utility Folder
- `misc/` - Additional utilities and helpers
  - `misc/cpp/` - C++ helpers (e.g., std::string support)
  - `misc/fonts/` - Font data and utilities
  - `misc/debuggers/` - Debugger visualization helpers

## Files Maintained Manually

The following files are maintained manually and should not be auto-updated:

### ESP-IDF Component Configuration
- `CMakeLists.txt` - Build configuration for ESP-IDF
- `idf_component.yml` - Component metadata for ESP-IDF component manager

### Documentation and Scripts
- `README.md` - Project documentation
- `update_imgui.sh` - Manual update script
- `LICENSE` - License information

### Automation
- `.github/workflows/update-imgui.yml` - GitHub Actions workflow

## Version Tracking

The `IMGUI_VERSION` file contains the current ImGui version tag (e.g., `v1.90.0`). This file is updated automatically when ImGui is updated.

## Workflow Behavior

### Automatic Updates (Daily)
- Runs daily at 00:00 UTC
- Checks for new ImGui releases
- Downloads and extracts only core files
- Commits changes if new version is found

### Manual Updates
Two methods are available:

1. **GitHub Actions (Recommended)**
   - Go to Actions tab in GitHub
   - Select "Update ImGui Core" workflow
   - Click "Run workflow"
   - Optionally specify a version tag

2. **Local Script**
   ```bash
   # Update to latest version
   ./update_imgui.sh
   
   # Update to specific version
   ./update_imgui.sh v1.90.0
   ```

## Integration with ESP-IDF Projects

### Method 1: Component Manager (Recommended)

Add to your project's `idf_component.yml`:

```yaml
dependencies:
  imgui-core:
    git: https://github.com/Lemin2/imgui-core.git
```

### Method 2: Git Submodule

```bash
cd your-project/components
git submodule add https://github.com/Lemin2/imgui-core.git
```

### Method 3: Direct Clone

```bash
cd your-project/components
git clone https://github.com/Lemin2/imgui-core.git
```

## Build Configuration

The `CMakeLists.txt` registers the component with ESP-IDF's build system:
- Source files: All core `.cpp` files
- Include directories: Component root (for `imgui.h` and other headers)
- Dependencies: Can be extended as needed

## Customization

If you need to customize the build or add dependencies:

1. **Fork this repository**
2. **Modify `CMakeLists.txt`** to add custom sources or dependencies
3. **Update `idf_component.yml`** if needed for component dependencies
4. **Keep the workflow** to maintain automatic updates

## Excluded from This Component

To keep the component lightweight, the following are NOT included:

- `backends/` - Platform-specific rendering backends
  - You should add backends separately based on your display/input hardware
  - Common backends: OpenGL, Vulkan, SDL, GLFW, etc.

- `examples/` - Example applications
  - Refer to [official ImGui examples](https://github.com/ocornut/imgui/tree/master/examples)

- `docs/` - Documentation
  - Refer to [official ImGui documentation](https://github.com/ocornut/imgui)

## License

This ESP-IDF component wrapper: MIT License
Dear ImGui: MIT License

Both allow commercial use, modification, and distribution.
