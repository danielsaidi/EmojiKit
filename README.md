<p align="center">
    <img src="Resources/Icon-Plain.png" alt="Project Icon" width="250" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/EmojiKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/Swift-6.0-orange.svg" alt="Swift 6.0" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <a href="https://danielsaidi.github.io/EmojiKit"><img src="https://img.shields.io/badge/documentation-web-blue.svg" alt="Documentation" /></a>
    <img src="https://img.shields.io/github/license/danielsaidi/EmojiKit" alt="MIT License" title="MIT License" />
</p>



# EmojiKit

EmojiKit lets you use emoji-based features on all major Apple platforms (iOS, macOS, tvOS, watchOS & visionOS).

<p align="center">
    <img src ="Resources/Demo.gif" width="750" />
</p>

EmojiKit supports emojis, categories, unicode versions, localization, skin tones, etc. and has convenient SwiftUI components like ``EmojiGrid`` and ``EmojiScrollGrid``.



## Installation

EmojiKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/EmojiKit.git
```


## Support My Work

By [becoming a sponsor][Sponsors], you directly support the development & improvement of my various [open-source projects][OpenSource]. 

Every sponsor makes a real difference. Thank you for considering [supporting my work][Sponsors]!



## Features

EmojiKit provides a bunch of emoji-specific features:

* 😀 Emojis - An emoji model with many features.
* 🐻 Emoji Categories - Standard and custom emoji categories.
* 📦 Emoji Versions - All available emoji versions and their emojis.
* 🧩 Extensions - Emoji-related native type extensions.
* 👍🏾 Skin Tones - Skin tone information for supported emojis.
* 🖼️ Views - Emoji-specific views, like grids and pickers.

See the online [documentation][Documentation] for more information.



## Localization

EmojiKit is localized in the following languages:

* 🇨🇳 Chinese (Simplified)
* 🇬🇧 English
* 🇳🇱 Dutch
* 🇫🇷 French
* 🇩🇪 German
* 🇮🇹 Italian
* 🇯🇵 Japanese
* 🇰🇷 Korean
* 🇧🇷 Portuguese (Brazil)
* 🇷🇺 Russian
* 🇪🇸 Spanish
* 🇸🇪 Swedish

You can contribute by copying `Sources/Resources/en.lproj` and localizing it in another language.



## Getting started

The `Emoji` model can be used to parse a bunch of emoji-specific information, for instance:

```swift
Emoji("👍").unicodeIdentifier       // \\N{THUMBS UP SIGN}
Emoji("🚀").unicodeIdentifier       // \\N{ROCKET}
Emoji("👍").unicodeName             // Thumbs Up Sign
Emoji("👍🏿").unicodeName             // Thumbs Up Sign
Emoji("🚀").unicodeName             // Rocket
Emoji("😀").localizedName           // Grinning Face
Emoji("😀").localizedName(in: .swedish)  // Leende Ansikte
Emoji("👍").hasSkinToneVariants     // true
Emoji("🚀").hasSkinToneVariants     // false
Emoji("👍🏿").neutralSkinToneVariant  // 👍
Emoji("👍").skinToneVariants        // 👍👍🏻👍🏼👍🏽👍🏾👍🏿
```

The `EmojiCategory` enum defines standard and custom categories and their emojis, for instance:

```swift
EmojiCategory.smileysAndPeopleChars.emojis // 😀😃😄...
EmojiCategory.animalsAndNatureChars.emojis // 🐶🐱🐭...
EmojiCategory.foodAndDrinkChars.emojis     // 🍏🍎🍐...
```

The `EmojiVersion` enum defines Emoji versions and the emojis they introduced, for instance:

```swift
EmojiVersion.v15_1.emojis // 🙂‍↕️🙂‍↔️👩‍🦽‍➡️...
EmojiVersion.v15.emojis   // 🫨🫸🫷
EmojiVersion.v14.emojis   // 🫠🫢🫣
```

See the online [documentation][Documentation] for more information.



## Documentation

The online [documentation][Documentation] has more information, articles, code examples, etc.



## Demo Application

The `Demo` folder has a demo app that lets you explore the library and its components.



## Contact

Feel free to reach out if you have questions or want to contribute in any way:

* Website: [danielsaidi.com][Website]
* E-mail: [daniel.saidi@gmail.com][Email]
* Bluesky: [@danielsaidi@bsky.social][Bluesky]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]



## License

EmojiKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[Bluesky]: https://bsky.app/profile/danielsaidi.bsky.social
[Twitter]: https://twitter.com/danielsaidi
[Mastodon]: https://mastodon.social/@danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi

[Documentation]: https://danielsaidi.github.io/EmojiKit
[License]: https://github.com/danielsaidi/EmojiKit/blob/main/LICENSE
