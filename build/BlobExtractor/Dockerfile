FROM ubuntu:22.04

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    python3 \
    adb \
    android-tools-adb \
    android-tools-fastboot \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
RUN mkdir -p /home/blob-extractor
WORKDIR /home/blob-extractor

# Copy the extraction script
COPY extract-blobs.sh /home/blob-extractor/
RUN chmod +x /home/blob-extractor/extract-blobs.sh

# Set up the directory structure
RUN mkdir -p /home/blob-extractor/lineage/device/google/oriole
RUN mkdir -p /home/blob-extractor/output

CMD ["./extract-blobs.sh"]