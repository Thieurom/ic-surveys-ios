// swiftlint:disable superfluous_disable_command closure_body_length
//
//  LoginView.swift
//  Login
//
//  Created by Doan Thieu on 25/10/2022.
//

import Styleguide
import SwiftUI

public struct LoginView: View {

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingForm = false
    @State private var logoScale = 1.0
    @FocusState private var emailInFocus: Bool
    @FocusState private var passwordInFocus: Bool
    private let spacing: CGFloat = 40.0

    public var body: some View {
        ZStack {
            Asset.Images.background.swiftUIImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: showingForm ? 24.0 : 0.0, opaque: true)
                .overlay(OverlayView())
                .ignoresSafeArea()
                .onTapGesture {
                    emailInFocus = false
                    passwordInFocus = false
                }

            VStack {
                Spacer(minLength: spacing)

                Asset.Images.logo.swiftUIImage
                    .frame(maxHeight: .infinity)
                    .scaleEffect(logoScale)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.4).delay(0.5)) {
                            logoScale = 0.85
                            showingForm = true
                        }
                    }

                if showingForm {
                    form
                        .frame(maxHeight: .infinity)
                        .opacity(showingForm ? 1.0 : 0.0)

                    Spacer()
                        .frame(maxHeight: .infinity)
                }

                Spacer(minLength: spacing)
            }
        }
    }

    public init() {}
}

extension LoginView {

    private var form: some View {
        VStack(spacing: 20.0) {
            TextField("", text: $email)
                .placeholder(when: email.isEmpty) {
                    Text("Email")
                        .adaptiveFont(.neuzeitBook, size: 17.0)
                        .padding(.horizontal, 12.0)
                        .foregroundColor(Color.white.opacity(0.3))
                }
                .textFieldStyle(FieldStyle())
                .keyboardType(.emailAddress)
                .focused($emailInFocus)

            SecureField("", text: $password)
                .placeholder(when: password.isEmpty) {
                    Text("Password")
                        .adaptiveFont(.neuzeitBook, size: 17.0)
                        .padding(.horizontal, 12.0)
                        .foregroundColor(Color.white.opacity(0.3))
                }
                .textFieldStyle(FieldStyle())
                .focused($passwordInFocus)

            Button {} label: {
                Text("Log in")
                    .adaptiveFont(.neuzeitHeavy, size: 17.0)
                    .frame(maxWidth: .infinity, maxHeight: 56.0)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(12.0)
            }
        }
        .padding(.horizontal, 24.0)
    }
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
                .accentColor(.white)
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
