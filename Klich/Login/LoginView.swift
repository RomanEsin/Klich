//
//  LoginView.swift
//  Klich
//
//  Created by Роман Есин on 22.05.2021.
//

import SwiftUI

struct LoginView: View {

    @Binding var isLoggedIn: Bool

    @State var isLoggingIn = false

    @State var isLoadingRequest = false
    @State var username = ""
    @State var password = ""

    @State var hasError = false
    @State var errorText = ""

    @State var userType = 0

    func register() {
        let user = User(username: username, password: password, userType: userType)

        DispatchQueue.main.async {
            isLoadingRequest = true
            KlichAPI.register(user: user) { result in
                isLoadingRequest = false
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                    errorText = error.localizedDescription
                    hasError = true
                case .success(let token):
                    withAnimation {
                        isLoggedIn = true
                    }
                    print(token.token)
                }
            }
        }
    }

    func login() {
        let user = User(username: username, password: password, userType: userType)

        DispatchQueue.main.async {
            isLoadingRequest = true
            KlichAPI.login(user: user) { result in
                isLoadingRequest = false
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                    errorText = error.localizedDescription
                    hasError = true
                case .success(let token):
                    withAnimation {
                        isLoggedIn = true
                    }
                    print(token.token)
                }
            }
        }
    }

    var buttonDisabled: Bool {
        username.isEmpty || password.isEmpty || isLoadingRequest
    }

    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Spacer()

                Text(isLoggingIn ? "Вход" : "Регистрация")
                    .foregroundColor(.klichDarkBlue)
                    .font(.largeTitle.bold())
                    .padding(.vertical)

                Picker("", selection: $userType) {
                    Text("Студент")
                        .tag(0)
                    Text("Организация")
                        .tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical)

                VStack {
                    TextField("Username", text: $username)
                        .textContentType(.username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    Divider()
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)

                Spacer()

                Button(action: {
                    if isLoggingIn {
                        login()
                    } else {
                        register()
                    }
                }, label: {
                    VStack {
                        if isLoadingRequest {
                            ProgressView()
                        } else {
                            Text(isLoggingIn ? "Войти" : "Зарегистрироваться")
                        }
                    }
                    .foregroundColor(.white)
                    .frame(height: 25)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(buttonDisabled ? Color.klichPurple.opacity(0.2) : Color.klichPurple)
                    .cornerRadius(16)
                })
                .disabled(buttonDisabled)

                Button(action: {
                    withAnimation(.spring()) {
                        isLoggingIn.toggle()
                    }
                }, label: {
                    Text(isLoggingIn ? "Нету аккаунта? Зарегистрироваться" : "Уже есть аккаунт? Войти")
                        .foregroundColor(.klichPurple)
                        .frame(maxWidth: .infinity)
                        .padding(4)
                })
                .disabled(buttonDisabled)
            }
            .padding(.horizontal)
            .padding(.bottom, 70)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .ignoresSafeArea()
        .alert(isPresented: $hasError, content: {
            Alert(title: Text(errorText))
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false))
    }
}
