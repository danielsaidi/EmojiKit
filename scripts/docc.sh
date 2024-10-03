#!/bin/bash

# Build DocC documentation for a <TARGET> to .build/docs.

# USAGE: bash scripts/docc.sh <TARGET>

swift package resolve;

xcodebuild docbuild -scheme $1 -derivedDataPath /tmp/docbuild -destination 'generic/platform=iOS';

$(xcrun --find docc) process-archive \
transform-for-static-hosting /tmp/docbuild/Build/Products/Debug-iphoneos/$1.doccarchive \
--output-path .build/docs \
--hosting-base-path '$1';
