//
//  View+OnFirstAppear.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 21/07/2024.
//

import SwiftUI

extension View {
    public func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(FirstAppear(action: action))
    }
}

private struct FirstAppear: ViewModifier {
    let action: () -> Void

    @State private var hasAppeared = false

    func body(content: Content) -> some View {
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            action()
        }
    }
}
