<p align="center">
    <img src ="Resources/Logo_GitHub.png" alt="EmojiKit Logo" title="EmojiKit" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/EmojiKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/Swift-6.0-orange.svg" alt="Swift 6.0" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <img src="https://img.shields.io/github/license/danielsaidi/ApiKit" alt="MIT License" title="MIT License" />
        <a href="https://twitter.com/danielsaidi"><img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fdanielsaidi" alt="Twitter: @danielsaidi" title="Twitter: @danielsaidi" /></a>
    <a href="https://mastodon.social/@danielsaidi"><img src="https://img.shields.io/mastodon/follow/000253346?label=mastodon&style=social" alt="Mastodon: @danielsaidi@mastodon.social" title="Mastodon: @danielsaidi@mastodon.social" /></a>
</p>



## About EmojiKit

EmojiKit lets you use emoji-based features on all major Apple platforms (iOS, macOS, tvOS, watchOS & visionOS) using Swift & SwiftUI.

<p align="center">
    <img src ="Resources/Demo.gif" width="750" />
</p>

EmojiKit has all you need to work with emojis, including categories, support for localization & skin tones, unicode & version information, as well as convenient ``EmojiGrid`` and ``EmojiScrollGrid`` components.



## Installation

EmojiKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/EmojiKit.git
```


## Features

EmojiKit provides a bunch of emoji-specific features:

* 😀 Emojis - EmojiKit defines a structured emoji model.
* 🐻 Emoji Categories - EmojiKit defines all standard emoji categories.
* 📦 Emoji Versions - EmojiKit defines all emoji versions and their emojis.
* 🧩 Extensions - EmojiKit extends native types with emoji support.
* 🇸🇪 Localization - EmojiKit supports localizing all emojis and categories.
* 👍🏾 Skin Tones - EmojiKit provides emoji skin tone information.
* 🖼️ Views - EmojiKit has emoji-specific views, like grids and pickers.

See the online [documentation][Documentation] for more information.



## Getting started

The `Emoji` model can be used to parse a bunch of emoji-specific information, for instance:

```swift
Emoji("👍").unicodeIdentifier       // \\N{THUMBS UP SIGN}
Emoji("🚀").unicodeIdentifier       // \\N{ROCKET}
Emoji("👍").unicodeName             // Thumbs Up Sign
Emoji("👍🏿").unicodeName             // Thumbs Up Sign
Emoji("🚀").unicodeName             // Rocket
Emoji("😀").localizedName           // Grinning Face
Emoji("😀").localizedName(for: .swedish)  // Leende Ansikte
Emoji("👍").hasSkinToneVariants     // true
Emoji("🚀").hasSkinToneVariants     // false
Emoji("👍🏿").neutralSkinToneVariant  // 👍
Emoji("👍").skinToneVariants        // 👍👍🏻👍🏼👍🏽👍🏾👍🏿
```

See the online [documentation][Documentation] for more information.



## Documentation

The online [documentation][Documentation] has more information, articles, code examples, etc.



## Demo Application

The `Demo` folder has an app that lets you explore the library. 



## Support my work 

You can [sponsor me][Sponsors] on GitHub Sponsors or [reach out][Email] for paid support, to help support my [open-source projects][OpenSource].

Your support makes it possible for me to put more work into these projects and make them the best they can be.



## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* Website: [danielsaidi.com][Website]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]
* Twitter: [@danielsaidi][Twitter]
* E-mail: [daniel.saidi@gmail.com][Email]



## License

EmojiKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com

[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[Twitter]: https://twitter.com/danielsaidi
[Mastodon]: https://mastodon.social/@danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi

[Documentation]: https://danielsaidi.github.io/EmojiKit

[License]: https://github.com/danielsaidi/EmojiKit/blob/main/LICENSE
