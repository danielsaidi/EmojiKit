# Release notes

[EmojiKit](https://github.com/danielsaidi/EmojiKit) tries to honor semantic versioning:

* Deprecations can happen in any version.
* Deprecations are only removed in `major` updates.
* Breaking changes should only occur in `major` updates.
* Breaking changes *can* occur in `minor` & `patch` updates, if needed.



## 2.2

### 💡 Adjustments

* The package now uses Swift 6.1. 
* The demo app now targets iOS 26.



## 2.1

This version adds a `frequent` emoji category.

### ✨ Features

* `EmojiCategory` has new `.favorites`, `.frequent` and `.recent` builders.

### 💡 Adjustments

* `EmojiGrid` and `EmojiScrollGrid` only have a single initializer.
* `EmojiGrid` has a new `registerSelectionFor` init argument.
* `EmojiGridScrollView` no longer takes a geometry proxy parameter.

### 🗑️ Deprecations

* `Emoji.registerUserSelection` has been deprecated.



## 2.0

This version bumps deployment targets and removes deprecated code.

### 💥 Breaking Changes

* EmojiKit now targets iOS 16 and aligned platform versions.
* All previously deprecated code has been removed.



## 1.7.4

### 🐛 Bug Fixes

This version removes the escape key selection reset.



## 1.7.3

### 🐛 Bug Fixes

This version fixes a single-category grid selection check.



## 1.7.2

Thanks to [@MrRavikiran](https://github.com/MrRavikiran), EmojiKit is now located in Dutch.

🌐 Localization

* 🇳🇱 Dutch



## 1.7.1

Thanks to [@aidar](https://github.com/Aidar), EmojiKit is now located in more locales.

🌐 Localization

* 🇧🇷 Brazilian Portuguese
* 🇫🇷 French 
* 🇯🇵 Japanese
* 🇰🇷 Korean
* 🇨🇳 Simplified Chinese



## 1.7

Thanks to [@aidar](https://github.com/Aidar), EmojiKit is now located in more locales.

🌐 Localization

* 🇮🇹 Italian
* 🇷🇺 Russian



## 1.6.3

### 🐛 Bug Fixes

This version fixes an incorrect naming of `EmojiVersion.v16_0`.


## 1.6.2

This version makes it easier to create and use custom persisted categories.

### ✨ Features

* `EmojiCategory` has a new `.persisted(_.)` builder.
* `EmojiCategory.Persisted` can now define initial emojis.
* `EmojiCategory.Persisted` has new name and icon properties.



## 1.6.1

This version marks 16.0 as the latest version.



## 1.6

This version adds Emojis 16.0 emojis: 🫩🫆🪾🫜🫟🪉🪏🇨🇶.

This version also localizes all emojis in German.

This version also converts some computed properties to constants to improve performance.

The new `EmojiCategory.Persisted` struct replaces the old `EmojiCategory.PersistedCategory` enum.

### ‼️ Important

You need Xcode 16.3 for this version, since it uses new OS checks. 

🌐 Localization

* 🇩🇪 All emojis and categories are now localized in German.

### ✨ Features

* `EmojiCategory` now implements `Sendable`.
* `EmojiCategory.Persisted` is a new persisted category type.
* `EmojiVersion` has a new `v16_0` version with the latest emojis.

### 💡 Adjustments

* `Emoji.all` has been converted to a constant.
* `EmojiCategory.standard` is no longer computed. 

### 🗑️ Deprecations

* `EmojiCategory.frequent` has been deprecated.
* `EmojiCategory.standard` has been renamed to `standardCategories`.
* `EmojiCategory.PersistedCategory` has been replaced with `EmojiCategory.Persisted`.



## 1.5.1

### 🐛 Bug Fixes

* This version fixes a crash that occurred when persisting emojis.



## 1.5

### ✨ Features

* `EmojiCategory` has made all persisted emoji category functions public.
* `EmojiCategory` can now set a max count for each persisted emoji category.

### 💡 Adjustments

* `Character.isEmoji` now checks all emoji versions from 15 and up.
* `EmojiCategory` now uses the persisted emoji category max count as a default cap.

### 🐛 Bug Fixes

* `EmojiCategory.recentEmojis` now uses the correct persistency key.



## 1.4.2

This version makes the 1.4.1 bug fix work on iOS 17 and earlier too.



## 1.4.1

This version cleans up the emoji grid initializers.

💡 Adjustments

* `EmojiGrid` and `EmojiScrollGrid` has separate initializers for emojis and categories.

### 🐛 Bug Fixes

* `EmojiGrid` and `EmojiScrollGrid` now triggers the provided action even if no selection binding is set.



## 1.4

This version adds support for Spanish.  

🌐 Localization

* 🇪🇸 All emojis and categories have been localized in Spanish. 



## 1.3.1

This version fixes some bugs and adjusts the grid style accordingly.  

💡 Adjustments

* `Emoji.GridStyle` increases the default padding, after fixing the padding bug.
* The `.firstIndex(of:)` array extension no longer uses neutral skin tone as ID.

### 🐛 Bug Fixes

* This update removes an additional padding that was applied by the scroll grid.
* This fixes a random arrow key bug that could cause invalid up/down navigation.
* The first index adjustment fixes invalid arrow key navigation for some emojis.




## 1.3

This version adds a new `recent` category and changes the `standard` category collection.  

✨ Features

* `Emoji` has a new `registerUserSelection` function.
* `EmojiCategory` has a new `recent` category, for the most recent emojis.
* `EmojiCategory` has translations for `favorites` and `recent` categories.
* `EmojiGrid` automatically registers emojis and updates affected categories.

💡 Adjustments

* `EmojiCategory.standard` no longer includes `.recent` or `.frequent` by default.
* `EmojiGrid` uses optional init parameters with `nil` default values, to reduce code duplication.

### 🗑️ Deprecations

* `EmojiCategory` no longer implements `CaseIterable`, since categories are not a definitive list.
* `EmojiCollection.standardWithoutFrequent` is renamed to `EmojiCollection.standardWithoutRecent`.
* `EmojiGrid` no longer takes a persisted category in the initializer and renames some init parameters.
* `EmojiScrollGrid` has been renamed to `EmojiGridScrollView`.



## 1.3

This version adds a new `recent` category and changes the `standard` category collection.  

✨ Features

* `Emoji` has a new `registerUserSelection` function.
* `EmojiCategory` has a new `recent` category, for the most recent emojis.
* `EmojiCategory` has translations for `favorites` and `recent` categories.
* `EmojiGrid` automatically registers emojis and updates affected categories.

💡 Adjustments

* `EmojiCategory.standard` no longer includes `.recent` or `.frequent` by default.
* `EmojiGrid` uses optional init parameters with `nil` default values, to reduce code duplication.

### 🗑️ Deprecations

* `EmojiCategory` no longer implements `CaseIterable`, since categories are not a definitive list.
* `EmojiCollection.standardWithoutFrequent` is renamed to `EmojiCollection.standardWithoutRecent`.
* `EmojiGrid` no longer takes a persisted category in the initializer and renames some init parameters.
* `EmojiScrollGrid` has been renamed to `EmojiGridScrollView`.



## 1.2.1 - 1.2.3

✨ Features

* `EmojiGrid` now provides category index to the view builder params.
* `EmojiGrid` now properly filters out empty categories when created.
* `EmojiGridStyle` has a new `sectionSpacing` that is applied to the grid section header.



## 1.2

✨ Features

* `Emoji` and `EmojiCategory` conform to `Transferable`.
* `EmojiGrid` has a new `categoryEmojis` array builder.

💡 Adjustments

* `Emoji` now matches if a query is identical to its char.



## 1.1.1

This version optimizes emoji search and adjusts some localized texts.

This version also renames some functions to use `in locale` instead of `for locale` terminology.



## 1.1

This version improves localization and localizes emojis in Swedish as well.



## 1.0.1

This version makes `EmojiVersion` implement `Identifiable` and adds a `displayName` property to it.



## 1.0

This version removes all deprecated code and uses Swift 6.



## 0.9

This version deprecates the `EmojiProvider` concept, makes the `.frequent` and `.favorites` categories use static backing values and makes `EmojiCategory` implement `CaseIterable`.

This is the last minor version before the upcoming, first major version. The goal will be to clean up the library as much as possible before that bump.

### ✨ New Features

* `EmojiCategory` now implements `CaseIterable`.
* `EmojiCategory` has new functions to work with persisted categories.
* `EmojiCategory.PersistedCategory` is a new enum to simplify working with persisted categories.
* `EmojiCategory.favoriteEmojis` is a new value that can be used to populate the `.favorites` category.
* `EmojiCategory.frequentEmojis` is a new value that can be used to populate the `.frequent` category.
* `EmojiGrid` now supports updating any persisted category when emojis are tapped or picked.

### 💡 Adjustments

* `EmojiCategory.search` now resolves to a `.custom` category.

### 🗑️ Deprecations

* `EmojiCategory.all` has been renamed to `.standard`.
* `EmojiProvider` has been deprecated since each custom category can now be persisted.



## 0.8

This version renames `FrequentEmojiProvider` to `EmojiProvider` and changes the protocol a bit, then groups all implementations within a new namespace.

### ✨ New Features

* `EmojiCategory.favorites` is a new category.
* `EmojiProviders` is a new provider namespace.
* `EmojiProviders.FavoriteProvider` is a new provider.

### 🗑️ Deprecations

* `FrequentEmojiProvider` has been renamed to `EmojiProvider`.
* `MostRecentEmojiProvider` has been renamed to `EmojiProviders.MostRecentProvider`.



## 0.7

This version adds support for keyboard selections, queries and a skin tone popover to the grid.

Note that keyboard selection and focus only works in iOS 17, macOS 14, etc. 

### ✨ New Features

* `Emoji.SkintonePopover` is a new popover view.
* `EmojiCategory` has a new `.search(query:)` category.
* `EmojiGrid` & `EmojiScrollGrid` now supports applying a query.
* `EmojiGrid` & `EmojiScrollGrid` now supports keyboard selection.
* `EmojiGrid` & `EmojiScrollGrid` now supports showing a skin tone popover.

### 💡 Adjustments

* `EmojiGrid` & `EmojiScrollGrid` have replaced two initializers with a single one.



## 0.6

This version adds support for Emoji 15.1.

Emoji 15.1 adds these new emojis and skintones:
🙂‍↕️🙂‍↔️👩‍🦽‍➡️🧑‍🦽‍➡️👨‍🦽‍➡️👩‍🦼‍➡️🧑‍🦼‍➡️👨‍🦼‍➡️🚶‍♀️‍➡️🚶‍➡️🚶‍♂️‍➡️👩‍🦯‍➡️🧑‍🦯‍➡️👨‍🦯‍➡️🧎‍♀️‍➡️🧎‍➡️🧎‍♂️‍➡️🏃‍♀️‍➡️🏃‍➡️🏃‍♂️‍➡️🐦‍🔥🍋‍🟩🍄‍🟫⛓️‍💥🧑‍🧑‍🧒🧑‍🧒‍🧒🧑‍🧒🧑‍🧑‍🧒‍🧒



## 0.5

This version adds support for strict concurrency.

The strict concurrency change required the library to remove the shared `FrequentEmojiProvider`.

A side-effect of this is that the `.frequent` emoji category no longer defines any emojis, and is now only used as a placeholder to defines the id, title, icon, etc. for that category.

While this may seem more complicated, it *is* actually better, since it lets us use different providers instead of relying on a single instance. It's also more obvious when using the SDK.

The various views, like `EmojiGrid` and the new `EmojiScrollGrid`, will also automatically use a `MostRecentEmojiProvider` which lets you completely ignore this architectural change in most cases.

This version also adds a demo app to the repository, to make it easier to play around with it.  

### ✨ New Features

* `Emoji` now conforms to `Hashable`.
* `Emoji.GridSelection` now conforms to `Hashable`.
* `EmojiCategory` is refactored to have a concurrent-safe cache.
* `EmojiScrollGrid` is a new grid that auto-scrolls to the selection.
* `MostRecentEmojiProvider` now lets you use a custom persistency key.
* `ScrollViewProxy` can now scroll to a specific `Emoji.GridSelection`.

### 💡 Adjustments

* `EmojiCategory.frequent` no longer returns any emojis.
* `EmojiGrid` now lets you inject a custom frequent emoji provider.



## 0.4

This version adds a new EmojiGrid component.

### ✨ New Features

* `EmojiGrid` is a new grid component.
* `EmojiGridStyle` is a new, environment-based style.
* `Emoji` has more nested components that are used by the grid. 



## 0.3

This version makes the EmojiKit foundation open-source.

The biggest changes in this version, is that there are no longer any throwing SDK features. This version also moves types out from the `Emoji` type, since the SDK is smaller than before.

This version also removes UI components and assets. These will be available in future updates.



## 0.2

This update tweaks a few things in EmojiKit.

### 🐛 Bug Fixes

* This update fixes a problem that made the SDK not include macOS support
* This update fixes a bundle problem when resolving images and localized strings.



## 0.1

This is the very first beta release of EmojiKit.

### ✨ New Features

* `Emoji` is a struct with Emoji-specific properties and features, and also serves as a namespace for the library.
* `Emoji` supports unicode information, localization, search, categories, skin tones, and emoji version information.
* `Emoji` also has `Grid` and `Picker` UI components.  
