// swiftlint:disable superfluous_disable_command closure_body_length
//
//  LoginView.swift
//  Login
//
//  Created by Doan Thieu on 25/10/2022.
//

import SwiftUI

public struct LoginView: View {

    @State private var email: String = ""
    @State private var password: String = ""

    public var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 20.0) {
                TextField("", text: $email)
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
                            .padding(.horizontal, 12.0)
                            .foregroundColor(Color.white.opacity(0.3))
                    }
                    .textFieldStyle(FieldStyle())

                SecureField("", text: $password)
                    .placeholder(when: password.isEmpty) {
                        Text("Password")
                            .padding(.horizontal, 12.0)
                            .foregroundColor(Color.white.opacity(0.3))
                    }
                    .textFieldStyle(FieldStyle())

                Button {} label: {
                    Text("Log in")
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, maxHeight: 56.0)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(12.0)
                }
            }
            .padding(.horizontal, 24.0)
        }
    }

    public init() {}
}

extension LoginView {

    fileprivate struct FieldStyle: TextFieldStyle {

        // swiftlint:disable:next identifier_name
        func _body(configuration: TextField<_Label>) -> some View {
            configuration
                .padding(.horizontal, 12.0)
                .frame(height: 56.0)
                .cornerRadius(12.0)
                .background(
                    RoundedRectangle(cornerRadius: 12.0)
                        .fill(Color.white.opacity(0.18))
                )
                .foregroundColor(.white)
        }
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {

    static var previews: some View {
        LoginView()
    }
}
#endif
