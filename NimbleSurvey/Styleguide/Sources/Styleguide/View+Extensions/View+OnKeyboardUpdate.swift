//
//  View+OnKeyboardUpdate.swift
//  Styleguide
//
//  Created by Doan Thieu on 10/11/2022.
//

import SwiftUI

struct KeyboardObserver: ViewModifier {

    private let keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
    private let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)

    private let action: (CGFloat) -> Void

    init(action: @escaping (CGFloat) -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        GeometryReader { reader in
            content
                .onReceive(keyboardWillShow) { notification in
                    let keyboardFrameKey = UIResponder.keyboardFrameEndUserInfoKey
                    guard let keyboardFrame = notification.userInfo?[keyboardFrameKey] as? CGRect else { return }

                    action(keyboardFrame.height - reader.safeAreaInsets.bottom)
                }
                .onReceive(keyboardWillHide) { _ in
                    action(0)
                }
        }
    }
}

extension View {

    public func onKeyboardUpdate(perform action: @escaping (CGFloat) -> Void) -> some View {
        modifier(KeyboardObserver(action: action))
    }
}
