#!/bin/bash
# Manual script to update ImGui core files
# Usage: ./update_imgui.sh [version]
# Example: ./update_imgui.sh v1.90.0
# If no version is specified, it will fetch the latest release

set -e

VERSION="$1"

if [ -z "$VERSION" ]; then
    echo "Fetching latest ImGui release..."
    VERSION=$(curl -s https://api.github.com/repos/ocornut/imgui/releases/latest | grep '"tag_name"' | sed -E 's/.*"tag_name": "([^"]+)".*/\1/')
    if [ -z "$VERSION" ]; then
        echo "Error: Could not fetch latest version"
        exit 1
    fi
    echo "Latest version: $VERSION"
else
    echo "Using specified version: $VERSION"
fi

# Check if already up to date
if [ -f "IMGUI_VERSION" ]; then
    CURRENT_VERSION=$(cat IMGUI_VERSION)
    if [ "$CURRENT_VERSION" = "$VERSION" ]; then
        echo "Already up to date with version $VERSION"
        exit 0
    fi
fi

echo "Downloading ImGui $VERSION..."
curl -L -o imgui.zip "https://github.com/ocornut/imgui/archive/refs/tags/${VERSION}.zip"

echo "Extracting files..."
unzip -q imgui.zip

# Find the extracted directory (more robust than ls)
IMGUI_DIR=$(find . -maxdepth 1 -type d -name "imgui-*" | head -n 1)
if [ -z "$IMGUI_DIR" ]; then
    echo "Error: Could not find extracted imgui directory"
    exit 1
fi
IMGUI_DIR="${IMGUI_DIR}/"

echo "Removing old ImGui files..."
find . -maxdepth 1 -name "*.cpp" -type f -delete
find . -maxdepth 1 -name "*.h" -type f -delete
rm -rf misc/

echo "Copying core source files..."
cp "${IMGUI_DIR}"*.cpp . 2>/dev/null || true
cp "${IMGUI_DIR}"*.h . 2>/dev/null || true

echo "Copying misc folder..."
cp -r "${IMGUI_DIR}misc" . 2>/dev/null || true

echo "Saving version info..."
# Remove 'v' prefix from version before saving
VERSION_NUM="${VERSION#v}"
echo "$VERSION_NUM" > IMGUI_VERSION

echo "Updating idf_component.yml version..."
echo "Setting version to $VERSION_NUM"
sed -i "s/^version: .*/version: \"$VERSION_NUM\"/" idf_component.yml

echo "Cleaning up..."
rm -rf imgui.zip imgui-*/

echo ""
echo "ImGui $VERSION has been successfully updated!"
echo ""
echo "Files updated:"
echo "  - Core source files: *.cpp, *.h"
echo "  - Misc utilities: misc/"
echo ""
echo "Next steps:"
echo "  1. Review the changes: git status"
echo "  2. Commit the changes: git add . && git commit -m 'Update ImGui to $VERSION_NUM'"
echo "  3. Push the changes: git push"
echo "  4. Create and push git tag: git tag -a '$VERSION_NUM' -m 'ImGui $VERSION_NUM' && git push origin '$VERSION_NUM'"
echo "  5. (Optional) Create GitHub release via GitHub UI or gh CLI"
