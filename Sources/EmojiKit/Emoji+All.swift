//
//  Emoji+All.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-11-02.
//  Copyright © 2023-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {

    /// Get all emojis from all standard categories.
    ///
    /// This property only returns emojis that are available
    /// to the current runtime.
    static let all: [Emoji] = {
        let emojis = EmojiCategory.standardCategories.flatMap { $0.emojis }
        emojis.forEach { _ = $0.hasSkinToneVariants }
        return emojis
    }()
}

public extension Collection where Element == Emoji {

    /// Get all available emojis from all categories.
    ///
    /// This property only returns emojis that are available
    /// to the current runtime. 
    static var all: [Element] {
        Element.all
    }
}

#if os(iOS) || os(macOS)
#Preview {
    
    struct Preview: View {
        
        var columns = [GridItem(.adaptive(minimum: 30))]
        
        @State
        private var query = "grin"
        
        var emojis: [Emoji] {
            Emoji.all.matching(query)
        }
        
        var body: some View {
            NavigationView {
                #if os(macOS)
                EmptyView()
                #endif
                ScrollView(.vertical) {
                    LazyVGrid(
                        columns: columns,
                        spacing: 10
                    ) {
                        ForEach(emojis) { emoji in
                            Text(emoji.char)
                                .font(.title)
                        }
                    }
                    .padding()
                }
                .searchable(text: $query)
            }
        }
    }
    
    return Preview()
}
#endif
