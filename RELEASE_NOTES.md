# Release notes

[EmojiKit](https://github.com/danielsaidi/EmojiKit) tries to honor semantic versioning:

* Deprecations can happen in any version.
* Deprecations are only removed in `major` updates.
* Breaking changes should only occur in `major` updates.
* Breaking changes *can* occur in `minor` & `patch` updates, if needed.



## 2.3

This version improves the grid performance and adds some styling options.

To improve grid performance and make grid selection more reliable, a `selection` binding is now required. Make sure to address all warnings to avoid any faulty behavior.

In the notes below, `EmojiGridScrollView` has the same changes as `EmojiGrid`.

### ✨ Features

* `Collection<EmojiCategory>` has a new `.standardGrid` value.
* `EmojiGrid` has a new `category` binding and makes it´s `selection` mandatory.
* `Emoji.SkintonePopover` has a new `.emojiSkintonePopoverStyle` view modifier.
* `Emoji.SkintonePopoverStyle` can be used to set the visual style of a popover.

### 💡 Changes

* `EmojiGrid` has a much faster selection handling.
* `EmojiGrid` renames and removes some init parameters.
* `EmojiGrid` now persists to `.frequent` and `.recent` by default.

### 🗑️ Deprecations

* `EmojiGrid` no longer takes an `emojis` list - modify `categories` instead.
* `EmojiGrid` no longer takes an `categoryEmojis` list - modify `categories` instead.



## 2.2.1

### 🐛 Bug Fixes

Thanks to [@josselin-oudry](https://github.com/josselin-oudry) the emoji grid skintone popover now works on iOS 16.



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
* `EmojiGrid` has a new `category` init argument.
* `EmojiGrid` has a new `addSelectedEmojisTo` init argument.
* `EmojiGridScrollView` no longer takes a geometry proxy parameter.

### 🗑️ Deprecations

* `Emoji.registerUserSelection` has been deprecated.



## 2.0

This version bumps deployment targets and removes deprecated code.

### 💥 Breaking Changes

* EmojiKit now targets iOS 16 and aligned platform versions.
* All previously deprecated code has been removed.
