//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-06-07.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import EmojiKit
import SwiftUI

struct ContentView: View {
    
    @FocusState var isFocused

    @State var query = ""
    @State var category: EmojiCategory?
    @State var selection: Emoji.GridSelection?
    @State var sizeMode = 1.0

    var body: some View {
        NavigationStack {
            EmojiGridScrollView(
                axis: .vertical,
                category: $category,
                selection: $selection,
                query: query,
                action: { print($0) },
                sectionTitle: { $0.view },
                gridItem: { $0.view }
                // gridItem: { $0.view.draggable($0.emoji) } Dragging conflicts with skintone popover.
            )
            .focused($isFocused)
            .navigationTitle(selection?.category?.localizedName ?? "EmojiKit")
            #if os(iOS)
            .searchable(text: $query, placement: .navigationBarDrawer)
            #endif
        }
        .emojiGridStyle(gridStyle)
        .onReturnKeyPressIfAvailable {
            print(selection?.emoji?.char ?? "-")
        }
        .tint(.orange)
        .task { isFocused = true }
        .safeAreaInset(edge: .bottom) { slider }
    }
}

private extension ContentView {

    var gridStyle: EmojiGridStyle {
        switch sizeMode {
        case 0: .small
        case 1: .medium
        case 2: .large
        case 3: .extraLarge
        case 4: .extraExtraLarge
        default: .medium
        }
    }
}

private extension ContentView {

    var slider: some View {
        Slider(
            value: $sizeMode,
            in: 0...4,
            step: 1,
            minimumValueLabel: Text("Small"),
            maximumValueLabel: Text("Large")
        ) {
            Text("Emoji size")
        }
        .padding()
        .glassEffectIfAvailable()
        .padding()
    }
}

extension View {
    @ViewBuilder
    func glassEffectIfAvailable() -> some View {
        if #available(iOS 26.0, *) {
            self.glassEffect()
        } else {
            self
        }
    }

    @ViewBuilder
    func onReturnKeyPressIfAvailable(
        _ handler: @escaping () -> Void
    ) -> some View {
        if #available(iOS 17.0, *) {
            self.onKeyPress(.return) {
                handler()
                return .handled
            }
        } else {
            self
        }
    }
}

#Preview {
    ContentView()
}
