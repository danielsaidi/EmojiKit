# Release notes

EmojiKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecations should only be removed in `major` updates.
* Breaking changes should not occur in `minor` & `patch` updates.
* Breaking changes *can* occur in `minor` & `patch` updates, if needed.



## 1.3

This version adds a new `recent` category and changes the `standard` category collection.

✨ Features

* `EmojiCategory` has a new `recent` category.
* `EmojiCategory` has translations for `favorites` and `recent` categories.

💡 Adjustments

* `EmojiCategory.standard` no longer includes `.recent` or `.frequent` by default.

### 🗑️ Deprecations

* `EmojiCategory` no longer implements `CaseIterable`, since categories are not a definitive list.
* `EmojiCollection.standardWithoutFrequent` is renamed to `EmojiCollection.standardWithoutRecent`.



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
