//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-06-07.
//

import EmojiKit
import SwiftUI

struct ContentView: View {
    
    @FocusState var focusState
    
    @State var query = ""
    @State var selection = Emoji.GridSelection()

    var body: some View {
        NavigationStack {
            EmojiScrollGrid(
                axis: .vertical,
                categories: .standard,
                query: query,
                selection: $selection,
                persistedCategory: .frequent,
                action: { print($0) },
                section: { $0.view },
                item: { $0.view }
                // item: { $0.view.draggable($0.emoji) }
            )
            .searchable(text: $query)
        }
        .tint(.orange)
        .emojiGridStyle(.small)
    }
}

private extension ContentView {
    
    func fillStyle(_ isSelected: Bool) -> AnyShapeStyle {
        isSelected ? .init(.selection) : .init(.clear)
    }
}

#Preview {
    ContentView()
}
