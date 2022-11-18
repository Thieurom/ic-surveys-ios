//
//  LoginView.swift
//  Login
//
//  Created by Doan Thieu on 25/10/2022.
//

import Styleguide
import SurveyClientType
import SwiftUI

public struct LoginView: View {

    @State private var showingForm = false
    @State private var logoScale = 1.0
    @State private var bottomPadding: CGFloat = .zero
    @State private var isShowingSpinner = false
    @State private var isShowingLoginResult = false
    @State private var loginResultMessage: String?
    @FocusState private var emailInFocus: Bool
    @FocusState private var passwordInFocus: Bool
    @ObservedObject private var viewModel: LoginViewModel

    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        GeometryReader { _ in
            VStack(spacing: 0) {
                Asset.Images.logo.swiftUIImage
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .scaleEffect(logoScale)

                form.renderedIf(showingForm)
                    .frame(maxHeight: .infinity)
                    .opacity(showingForm ? 1.0 : 0.0)

                Spacer().frame(maxHeight: .infinity)
                    .renderedIf(showingForm && bottomPadding == .zero)
            }
            .padding(.bottom, bottomPadding)
            .onKeyboardUpdate { keyboardHeight in
                withAnimation(.easeIn(duration: 0.25)) {
                    bottomPadding = keyboardHeight
                }
            }
            .spinner(isPresented: $isShowingSpinner)
            .onReceive(viewModel.$isLoading) { isShowingSpinner = $0 }
            .onReceive(viewModel.$loginResult.dropFirst()) {
                isShowingLoginResult = true
                loginResultMessage = $0
            }
            .alert(
                "Login",
                isPresented: $isShowingLoginResult,
                presenting: loginResultMessage,
                actions: { _ in },
                message: { _ in
                    if let loginResultMessage = loginResultMessage {
                        Text(loginResultMessage)
                    }
                }
            )
        }
        .background(
            background
                .onTapGesture {
                    emailInFocus = false
                    passwordInFocus = false
                }
        )
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear {
            withAnimation(.easeIn(duration: 0.4).delay(0.5)) {
                logoScale = 0.85
                showingForm = true
            }
        }
    }
}

extension LoginView {

    private var form: some View {
        VStack(spacing: 20.0) {
            TextField("", text: $viewModel.email)
                .placeholder(when: viewModel.email.isEmpty) {
                    Text("Email")
                        .adaptiveFont(.neuzeitBook, size: 17.0)
                        .padding(.horizontal, 12.0)
                        .foregroundColor(Color.white.opacity(0.3))
                }
                .textFieldStyle(FieldStyle())
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .focused($emailInFocus)

            SecureField("", text: $viewModel.password)
                .placeholder(when: viewModel.password.isEmpty) {
                    Text("Password")
                        .adaptiveFont(.neuzeitBook, size: 17.0)
                        .padding(.horizontal, 12.0)
                        .foregroundColor(Color.white.opacity(0.3))
                }
                .textFieldStyle(FieldStyle())
                .focused($passwordInFocus)

            Button {
                viewModel.login()
            } label: {
                Text("Log in")
                    .adaptiveFont(.neuzeitHeavy, size: 17.0)
                    .frame(maxWidth: .infinity, maxHeight: 56.0)
                    .background(viewModel.isLoginEnabled ? Color.white : Color.gray)
                    .foregroundColor(.black)
                    .cornerRadius(12.0)
            }
            .disabled(!viewModel.isLoginEnabled)
        }
        .padding(.horizontal, 24.0)
    }

    private var background: some View {
        Asset.Images.background.swiftUIImage
            .resizable()
            .aspectRatio(contentMode: .fill)
            .blur(radius: showingForm ? 24.0 : 0.0, opaque: true)
            .overlay(OverlayView())
            .ignoresSafeArea()
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
        LoginView(viewModel: LoginViewModel(surveyClient: SurveyClientOk()))
    }
}
#endif
