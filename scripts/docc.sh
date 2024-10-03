swift package resolve;
          
xcodebuild docbuild -scheme EmojiKit -derivedDataPath /tmp/docbuild -destination 'generic/platform=iOS';

$(xcrun --find docc) process-archive \
transform-for-static-hosting /tmp/docbuild/Build/Products/Debug-iphoneos/EmojiKit.doccarchive \
--output-path docs \
--hosting-base-path 'EmojiKit';