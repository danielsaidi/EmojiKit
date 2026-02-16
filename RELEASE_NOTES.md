# Release notes

[EmojiKit](https://github.com/danielsaidi/EmojiKit) tries to honor semantic versioning:

* Deprecations can happen in any version.
* Deprecations are only removed in `major` updates.
* Breaking changes should only occur in `major` updates.
* Breaking changes *can* occur in `minor` & `patch` updates, if needed.



## 2.3.3

This version adds some emoji category functionality.

### ✨ Features

* `EmojiCategory` has new label properties and functions.
* `EmojiCategory` has new string-based `.custom` builder.



## 2.3.1, 2.3.2

This version fixes some scroll-related bugs.

### 🐛 Bug Fixes

* `EmojiGrid` now scrolls to an initial category or selection.
* `ScrollViewProxy` now scrolls to a selection in a more reliable way.



## 2.3

This version improves the grid performance and adds more bindings and styling options to both grids.

You can now pass in a `category` binding to be able to scroll to a certain category, and use it to observe the currently visible category. To improve grid performance and make grid selection more reliable, the `selection` binding is now required. 

Some old init parameters have been deprecated and no longer works, so make sure to address all warnings to avoid any faulty behavior. The deprecated logic will be removed in the next major version. 

In the notes below, `EmojiGridScrollView` has the same design changes as `EmojiGrid`.

### ✨ Features

* `Collection<EmojiCategory>` has a new `.standardGrid` value.
* `EmojiGrid` has a new `category` binding and makes the `selection` mandatory.
* `EmojiGrid` has a new `scrollViewProxy` property injected by the scroll view.
* `Emoji.SkintonePopover` has a new `.emojiSkintonePopoverStyle` view modifier.
* `Emoji.SkintonePopoverStyle` can be used to set the visual style of a popover.
* `ScrollViewProxy` has new scroll capabilities.

### 💡 Changes

* `EmojiGrid` has a much better performance than before.
* `EmojiGrid` renames and removes some initializer parameters.
* `EmojiGrid` by default adds emojis to `.frequent` and `.recent`.
* `EmojiGrid` now only *picks* and emojis on taps, and doesn't *select*.
* `EmojiScrollGrid` has moved all its scroll proxy logic to `EmojiGrid`.

### 🗑️ Deprecations

* `EmojiGrid` no longer takes `emojis` - modify `categories` instead.
* `EmojiGrid` no longer takes `categoryEmojis` - modify `categories` instead.



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
