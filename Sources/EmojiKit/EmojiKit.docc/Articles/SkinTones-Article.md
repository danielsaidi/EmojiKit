# Skin Tones

This article describes the EmojiKit skin tone support.

KeyboardKit defines skin tone variations for emojis that have such variations:

```swift
Emoji("👍").hasSkinToneVariants     // true
Emoji("🚀").hasSkinToneVariants     // false
Emoji("👍🏿").neutralSkinToneVariant  // 👍
Emoji("👍").skinToneVariants        // 👍👍🏻👍🏼👍🏽👍🏾👍🏿
Emoji("👍").skinToneVariantActions  // The above variants as keyboard actions
```

Skin tones will automatically be added as secondary actions when using the Pro emoji pickers. 

> Note: Skin tone support for emojis with multiple skin tone components are currently not supported, such as two persons kissing.
