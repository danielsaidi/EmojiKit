import SwiftUI

public extension ScrollViewProxy {

    @available(*, deprecated, message: "This doesn't work and will be removed.")
    func scrollToEmoji(_ emoji: Emoji) {
        scrollTo(emoji.id)
    }
}
