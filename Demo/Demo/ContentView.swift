//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-06-07.
//

import EmojiKit
import SwiftUI

struct ContentView: View {
    
    @State private var selection = Emoji.GridSelection(emoji: .init("🙄"), category: .smileysAndPeople)

    @FocusState var focusState1
    @FocusState var focusState2

    var body: some View {
        NavigationStack {
            VStack {
                grid(.vertical)
                    .focused($focusState1)
                grid(.horizontal)
                    .focused($focusState2)
            }
        }
        // .emojiGridStyle(.medium)
    }
}

private extension ContentView {
    
    func fillStyle(_ isSelected: Bool) -> AnyShapeStyle {
        isSelected ? .init(.selection) : .init(.clear)
    }
    
    func grid(_ axis: Axis.Set) -> some View {
        EmojiScrollGrid(
            axis: axis,
            categories: .all,
            selection: $selection,
            frequentEmojiProvider: MostRecentEmojiProvider(),
            section: { $0.view },
            item: { params in
                params.view
                    .background(
                        ContainerRelativeShape()
                            .fill(fillStyle(params.isSelected))
                    )
                    .containerShape(.rect(cornerRadius: 7))
            }
        )
    }
    
    /*
    
    private var fillStyle: AnyShapeStyle {
        #if os(iOS) || os(macOS)
        isSelected
            ? AnyShapeStyle(.selection)
            : AnyShapeStyle(.clear)
        #else
        AnyShapeStyle(.clear)
        #endif
    }
    */
    
    
}

#Preview {
    ContentView()
}
