#!/bin/bash

# Install XcodeGen if not installed
if ! command -v xcodegen &> /dev/null; then
    brew install xcodegen
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