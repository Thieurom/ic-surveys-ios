//
//  View+OnKeyboardUpdate.swift
//  Styleguide
//
//  Created by Doan Thieu on 10/11/2022.
//

import SwiftUI

struct KeyboardObserver: ViewModifier {

    private let action: (CGFloat) -> Void

    init(action: @escaping (CGFloat) -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        GeometryReader { reader in
            content
                .onAppear {
                    NotificationCenter.default.addObserver(
                        forName: UIResponder.keyboardWillShowNotification,
                        object: nil,
                        queue: .main
                    ) { notification in
                        let keyboardFrameKey = UIResponder.keyboardFrameEndUserInfoKey
                        guard let keyboardFrame = notification.userInfo?[keyboardFrameKey] as? CGRect else { return }

                        action(keyboardFrame.height - reader.safeAreaInsets.bottom)
                    }

                    NotificationCenter.default.addObserver(
                        forName: UIResponder.keyboardWillHideNotification,
                        object: nil,
                        queue: .main
                    ) { _ in action(0) }
                }
        }
    }
}

extension View {

    public func onKeyboardUpdate(perform action: @escaping (CGFloat) -> Void) -> some View {
        modifier(KeyboardObserver(action: action))
    }
}
