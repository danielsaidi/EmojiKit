//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-06-07.
//

import EmojiKit
import SwiftUI

struct ContentView: View {
    
    @State private var selection = Emoji.GridSelection()
    
    var body: some View {
        NavigationStack {
            VStack {
                grid(.vertical)
                grid(.horizontal)
            }
        }
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
                Button("\(params.emoji.char)") {
                    selection = .init(
                        emoji: params.emoji,
                        category: params.category
                    )
                }
                .aspectRatio(1, contentMode: .fill)
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
