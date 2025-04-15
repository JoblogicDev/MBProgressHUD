#!/bin/bash

# Check if the framework exists
if [ ! -d "./build/MBProgressHUD.xcframework" ]; then
    echo "Error: Framework not found. Please build it first."
    exit 1
fi

# Check the iOS device framework
echo "Checking iOS device framework..."
ls -la ./build/MBProgressHUD.xcframework/ios-arm64/MBProgressHUD.framework/Headers/

# Check the iOS simulator framework
echo "Checking iOS simulator framework..."
ls -la ./build/MBProgressHUD.xcframework/ios-arm64_x86_64-simulator/MBProgressHUD.framework/Headers/

echo "Verification complete." 
