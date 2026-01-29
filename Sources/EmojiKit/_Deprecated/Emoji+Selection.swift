import Foundation

public extension Emoji {
    
    @available(*, deprecated, message: "Use the persisted emojis directly instead.")
    func registerUserSelection() {
        EmojiCategory.Persisted.frequent.addEmoji(self)
    }
}
