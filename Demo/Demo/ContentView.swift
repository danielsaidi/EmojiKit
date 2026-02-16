//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-06-07.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import EmojiKit
import SwiftUI
import SwiftUIKit

struct ContentView: View {
    
    @FocusState var isFocused

    @State private var query = ""
    @State private var sizeMode = SizeMode.medium

    // Persisted Category - Uncomment to use this **********

//    @AppStorage("com.danielsaidi.emojikit.demo.category")
//    private var categoryValue: StorageValue<EmojiCategory> = .init()
//
//    @State private var selection: Emoji.GridSelection?
//
//    private var category: EmojiCategory? { categoryValue.value }
//    private var categoryBinding: Binding<EmojiCategory?> { $categoryValue.value }
//    private var selectionBinding: Binding<Emoji.GridSelection?> { $selection }

    // Persisted Selection - Uncomment to use this *********

    @AppStorage("com.danielsaidi.emojikit.demo.selection")
    private var selectionValue: StorageValue<Emoji.GridSelection> = .init()
    @State private var category: EmojiCategory?

    private var categoryBinding: Binding<EmojiCategory?> { $category }
    private var selectionBinding: Binding<Emoji.GridSelection?> { $selectionValue.value }

    var body: some View {
        NavigationStack {
            EmojiGridScrollView(
                axis: .vertical,
                category: categoryBinding,
                selection: selectionBinding,
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
                ToolbarItem { categoryPicker }
                ToolbarSpacer()
                ToolbarItem { sizePicker }
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
        let symbol = category?.symbolIconName ?? "face.smiling"
        return ToolbarPicker(title: "Category", image: symbol, selection: categoryBinding) {
            ForEach(EmojiCategory.standardCategories) {
                $0.label.tag($0)
            }
        }
        .labelStyle(.iconOnly)
    }

    var sizePicker: some View {
        ToolbarPicker(title: "Size", image: "square.resize", selection: $sizeMode) {
            ForEach(SizeMode.allCases) {
                Text($0.rawValue.camelCaseAsDisplayName())
                    .tag($0)
            }
        }
        .labelStyle(.iconOnly)
    }
}

struct ToolbarPicker<Value: Hashable, Content: View>: View {

    let title: String
    let image: String
    let selection: Binding<Value>
    let content: () -> Content

    var body: some View {
        Menu {
            Picker(title, selection: selection) {
                content()
            }
            .pickerStyle(.inline)
        } label: {
            Label(title, systemImage: image)
        }
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
