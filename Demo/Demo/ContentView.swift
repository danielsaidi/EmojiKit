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

    @State private var query = ""
    @State private var category: EmojiCategory?
    @State private var selection: Emoji.GridSelection?
    @State private var sizeMode = SizeMode.medium

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
            .navigationTitle(category?.localizedName ?? "EmojiKit")
            #if os(iOS)
            .searchable(text: $query, placement: .navigationBarDrawer)
            #endif
            .toolbar {
                ToolbarItem { categoryPickerItem }
                ToolbarSpacer()
                ToolbarItem { sizePickerItem }
            }
        }
        .emojiGridStyle(sizeMode.gridStyle)
        .tint(.orange)
        .task { isFocused = true }
    }
}

private extension ContentView {

    enum SizeMode: String, CaseIterable, Identifiable {

        case small, medium, large, extraLarge, extraExtraLarge

        var id: String { rawValue }

        var gridStyle: EmojiGridStyle {
            switch self {
            case .small: .small
            case .medium: .medium
            case .large: .large
            case .extraLarge: .extraLarge
            case .extraExtraLarge: .extraExtraLarge
            }
        }
    }
}

private extension ContentView {

    var categoryLabel: some View {
        let symbol = category?.symbolIconName ?? "face.smiling"
        return Label("Categories", systemImage: symbol)
    }

    var categoryPicker: some View {
        Picker(selection: $category) {
            ForEach(EmojiCategory.standardCategories) {
                $0.label.tag($0)
            }
        } label: {
            categoryLabel
        }
        .labelStyle(.iconOnly)
    }

    var categoryPickerItem: some View {
        #if os(macOS)
        categoryPicker
        #else
        Menu {
            categoryPicker
        } label: {
            categoryLabel
        }
        .labelStyle(.iconOnly)
        #endif
    }

    var sizeLabel: some View {
        Label("Size", systemImage: "square.resize")
    }

    var sizePicker: some View {
        Picker(selection: $sizeMode) {
            ForEach(SizeMode.allCases) {
                Text($0.rawValue.camelCaseAsDisplayName())
                    .tag($0)
            }
        } label: {
            sizeLabel
        }
        .labelStyle(.iconOnly)
    }

    var sizePickerItem: some View {
        #if os(macOS)
        sizePicker
        #else
        Menu {
            sizePicker
        } label: {
            sizeLabel
        }
        .labelStyle(.iconOnly)
        #endif
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
}

extension String {

    func camelCaseAsDisplayName() -> String {
        replacingOccurrences(
            of: "([a-z])([A-Z])",
            with: "$1 $2",
            options: .regularExpression
        )
        .capitalized
    }
}

#Preview {
    ContentView()
}
