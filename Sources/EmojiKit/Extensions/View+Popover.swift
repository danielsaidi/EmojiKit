//
//  View+Popover.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-12-14.
//  Copyright © 2023-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func popoverIfAvailable<Popover: View>(
        _ isPresented: Binding<Bool>,
        @ViewBuilder view: @escaping () -> Popover
    ) -> some View {
        #if os(iOS) || os(macOS)
        self.popover(isPresented: isPresented) {
            view().popoverSizeIfAvailable()
        }
        #else
        self
        #endif
    }
    
    @ViewBuilder
    func popoverSizeIfAvailable() -> some View {
        #if os(iOS)
        self.presentationCompactAdaptation(.popover)
        #else
        self
        #endif
    }
    
    @ViewBuilder
    func popoverColorIfAvailable(
        _ color: Color
    ) -> some View {
        #if os(iOS)
        self.presentationBackground(color)
        #else
        self
        #endif
    }
}
