# Quick Start Guide

## For Repository Maintainers

### First Time Setup

The repository is now configured but needs ImGui files. You have two options:

#### Option 1: Manual Workflow Trigger (Recommended)

1. Go to your repository on GitHub
2. Click on the "Actions" tab
3. Select "Update ImGui Core" from the workflows list
4. Click "Run workflow" button
5. Choose:
   - Leave version blank for latest ImGui release
   - Or enter a specific version like `v1.90.0`
6. Click "Run workflow"
7. Wait for the workflow to complete (usually < 1 minute)
8. The ImGui core files will be automatically committed

#### Option 2: Local Update Script

```bash
# Clone the repository first
git clone https://github.com/Lemin2/imgui-core.git
cd imgui-core

# Run the update script
./update_imgui.sh

# Or for a specific version
./update_imgui.sh v1.90.0

# Commit and push the changes
git add .
git commit -m "Add ImGui core files"
git push
```

### Automatic Updates

Once set up, the workflow will:
- Check for new ImGui releases every day at 00:00 UTC
- Automatically download and update if a new version is found
- Skip if already at the latest version
- No manual intervention needed

## For Component Users

### Installation Method 1: ESP-IDF Component Manager (Recommended)

Create or edit `idf_component.yml` in your project root:

```yaml
dependencies:
  imgui-core:
    git: https://github.com/Lemin2/imgui-core.git
```

Then run:
```bash
idf.py reconfigure
```

### Installation Method 2: Git Submodule

```bash
cd your-esp-idf-project
mkdir -p components
cd components
git submodule add https://github.com/Lemin2/imgui-core.git
cd ..
idf.py reconfigure
```

### Installation Method 3: Direct Clone

```bash
cd your-esp-idf-project/components
git clone https://github.com/Lemin2/imgui-core.git
cd ..
idf.py reconfigure
```

### Usage in Your Code

```cpp
#include "imgui.h"

void app_main(void) {
    // Initialize your display backend
    // (You need to implement this for your specific hardware)
    
    // Create ImGui context
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO();
    
    // Setup your platform/renderer bindings
    // (Implementation depends on your display hardware)
    
    // Main loop
    while (true) {
        // Start the Dear ImGui frame
        ImGui::NewFrame();
        
        // Your UI code here
        ImGui::Begin("Hello, ESP32!");
        ImGui::Text("This is ImGui running on ESP32!");
        ImGui::End();
        
        // Rendering
        ImGui::Render();
        // Send draw data to your display
        // (Implementation depends on your display hardware)
        
        vTaskDelay(pdMS_TO_TICKS(16)); // ~60 FPS
    }
}
```

## Important Notes

### What You Need to Provide

This component includes only the core ImGui files. You still need to implement:

1. **Display Backend**: Code to render ImGui draw data on your display
   - For LVGL: Use ImGui to LVGL conversion
   - For raw framebuffer: Implement drawing primitives
   - For TFT displays: Use your display library

2. **Input Backend**: Code to handle touch/keyboard input
   - Read touch coordinates
   - Update `io.MousePos`, `io.MouseDown[]`
   - Handle keyboard if available

### Example Backends

Common ESP32 backends you might use:

- **ESP-IDF + LVGL**: Use LVGL as rendering backend
- **ESP-IDF + TFT_eSPI**: Port ImGui to TFT_eSPI
- **ESP-IDF + SDL2**: Use SDL2 backend (if ported to ESP32)

You can find backend examples at:
https://github.com/ocornut/imgui/tree/master/backends

## Troubleshooting

### Build Errors

If you get build errors:
1. Make sure you're using ESP-IDF v4.0 or later
2. Check that the component is in the `components/` directory
3. Run `idf.py fullclean` and rebuild

### Missing Files

If ImGui files are missing:
1. Check if the workflow has run successfully
2. Manually trigger the workflow via GitHub Actions
3. Or run `./update_imgui.sh` locally

### Version Issues

To update to a specific ImGui version:
1. Go to GitHub Actions
2. Run "Update ImGui Core" workflow
3. Enter the desired version (e.g., `v1.90.0`)

Or locally:
```bash
./update_imgui.sh v1.90.0
git add .
git commit -m "Update to ImGui v1.90.0"
git push
```

## Getting Help

- **ImGui Documentation**: https://github.com/ocornut/imgui
- **ESP-IDF Documentation**: https://docs.espressif.com/projects/esp-idf/
- **Issues**: https://github.com/Lemin2/imgui-core/issues

## License

- This component wrapper: MIT License
- Dear ImGui: MIT License

Both are free for commercial use.
