#!/bin/bash

# Install XcodeGen if not installed
if ! command -v xcodegen &> /dev/null; then
    brew install xcodegen
fi

# Check and install required dependencies
echo "Checking required dependencies..."
if ! command -v yq &> /dev/null; then
    echo "Installing yq..."
    brew install yq
fi

# Clean previous build
rm -rf ./build

# Generate Xcode project
xcodegen generate

# Create build directory
mkdir -p ./build

# Build for iOS Simulator
xcodebuild archive \
    -scheme MBProgressHUD \
    -configuration Release \
    -destination 'generic/platform=iOS Simulator' \
    -archivePath './build/MBProgressHUD-Simulator.xcarchive' \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Build for iOS Device
xcodebuild archive \
    -scheme MBProgressHUD \
    -configuration Release \
    -destination 'generic/platform=iOS' \
    -archivePath './build/MBProgressHUD-Device.xcarchive' \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Create XCFramework
xcodebuild -create-xcframework \
    -framework './build/MBProgressHUD-Simulator.xcarchive/Products/Library/Frameworks/MBProgressHUD.framework' \
    -framework './build/MBProgressHUD-Device.xcarchive/Products/Library/Frameworks/MBProgressHUD.framework' \
    -output './build/MBProgressHUD.xcframework'

# Copy headers to both frameworks
echo "Copying headers to frameworks..."
mkdir -p "./build/MBProgressHUD.xcframework/ios-arm64/MBProgressHUD.framework/Headers"
mkdir -p "./build/MBProgressHUD.xcframework/ios-arm64_x86_64-simulator/MBProgressHUD.framework/Headers"
cp -R "Sources/Library/include/"* "./build/MBProgressHUD.xcframework/ios-arm64/MBProgressHUD.framework/Headers/"
cp -R "Sources/Library/include/"* "./build/MBProgressHUD.xcframework/ios-arm64_x86_64-simulator/MBProgressHUD.framework/Headers/"

# Verify headers
echo "Verifying headers..."
ls -la ./build/MBProgressHUD.xcframework/ios-arm64/MBProgressHUD.framework/Headers/
ls -la ./build/MBProgressHUD.xcframework/ios-arm64_x86_64-simulator/MBProgressHUD.framework/Headers/

echo "XCFramework created at ./build/MBProgressHUD.xcframework"

XC_FRAMEWORK_PATH="./build/${FRAMEWORK_NAME}.xcframework"
# Bump patch version in version.yml
echo "Bumping patch version..."
OLD_VERSION=$(yq e '.version' version.yml)
IFS='.' read -r MAJOR MINOR PATCH <<< "$OLD_VERSION"
NEW_PATCH=$((PATCH + 1))
NEW_VERSION="${MAJOR}.${MINOR}.${NEW_PATCH}"

# Update version.yml
yq e ".version = \"${NEW_VERSION}\"" -i version.yml
echo "New version: ${NEW_VERSION}"

# Define zip file name with version
VERSION=$NEW_VERSION
ZIP_FILE="${VERSION}-${FRAMEWORK_NAME}.xcframework.zip"
echo "Creating zip file..."
cd ./build
zip -r "../${ZIP_FILE}" "${FRAMEWORK_NAME}.xcframework"
cd ..
