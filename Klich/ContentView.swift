//
//  ContentView.swift
//  Klich
//
//  Created by Роман Есин on 22.05.2021.
//

import SwiftUI

struct TokenResponse: Codable {
    let token: String
}

struct User: Codable {
    let username: String
    let password: String?
}

class UserDefaultsManager {
    static var shared = UserDefaultsManager()

    private init() {}
}

class NetworkManager {
    static let rootURL = URL(string: "http://127.0.0.1:8000/")!

    static func register(user: User) {
        let urlString = "http://127.0.0.1:8000/register"
        let url = URL(string: urlString)!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            print(error)
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }

            print(String(data: data!, encoding: .utf8))
        }
    }
}

struct ContentView: View {

    @State var username = ""
    @State var password = ""

    func register() {
        let user = User(username: username, password: password)
        NetworkManager.register(user: user)
    }

    func login() {

    }

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            TextField("Username", text: $username)
            Divider()
            TextField("Password", text: $password)
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
                Text("Уже есть аккаунт")
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .infinity)
                    .padding(4)
            })
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
