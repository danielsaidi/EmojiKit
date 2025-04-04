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
            EmojiGridScrollView(
                axis: .vertical,
                // categories: .standard,
                query: query,
                selection: $selection,
                action: { print($0) },
                sectionTitle: { $0.view },
                gridItem: { $0.view }
                // gridItem: { $0.view.draggable($0.emoji) } Dragging conflicts with skintone popover.
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
