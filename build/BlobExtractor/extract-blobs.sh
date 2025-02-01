#!/bin/bash

echo "Starting blob extraction process..."

# Check if device is connected
if ! adb devices | grep -q "device$"; then
    echo "Error: No device connected or device not authorized"
    echo "Please ensure:"
    echo "1. Your device is connected via USB"
    echo "2. USB debugging is enabled"
    echo "3. You have authorized the computer on your device"
    exit 1
fi

# Create temporary lineage directory structure
cd /home/blob-extractor/lineage

# Clone necessary repositories
echo "Cloning device repository..."
git clone https://github.com/LineageOS/android_device_google_oriole.git device/google/oriole

# Run extraction script
echo "Running extraction script..."
cd device/google/oriole
./extract-files.sh

# Check if vendor directory was created and contains files
if [ -d "/home/blob-extractor/lineage/vendor/google/oriole" ]; then
    echo "Creating backup archive..."
    cd /home/blob-extractor/lineage
    tar -czf /home/blob-extractor/output/oriole-blobs.tar.gz vendor/google/oriole/
    echo "Blob extraction complete! Archive saved to output/oriole-blobs.tar.gz"
else
    echo "Error: Blob extraction failed - vendor directory not found"
    exit 1
fi