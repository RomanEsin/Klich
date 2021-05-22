//
//  LoginView.swift
//  Klich
//
//  Created by Роман Есин on 22.05.2021.
//

import SwiftUI

struct LoginView: View {

    @Binding var isLoggedIn: Bool

    @State var username = ""
    @State var password = ""

    func register() {
        let user = User(username: username, password: password)
        KlichAPI.register(user: user) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let token):
                isLoggedIn = true
                print(token.token)
            }
        }
    }

    func login() {
        let user = User(username: username, password: password)
        KlichAPI.login(user: user) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let token):
                isLoggedIn = true
                print(token.token)
            }
        }
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Spacer()

                VStack {
                    TextField("Username", text: $username)
                    Divider()
                    TextField("Password", text: $password)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)

                Spacer()

                Button(action: {
                    register()
                }, label: {
                    Text("Зарегистрироваться")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(16)
                })

                Button(action: {
                    login()
                }, label: {
                    Text("Уже есть аккаунт? Войти")
                        .foregroundColor(.accentColor)
                        .frame(maxWidth: .infinity)
                        .padding(4)
                })
            }
            .padding(.horizontal)
            .padding(.bottom, 50)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .ignoresSafeArea()
    }
}
