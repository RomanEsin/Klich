//
//  ContentView.swift
//  Klich
//
//  Created by Роман Есин on 22.05.2021.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var userData = UserData()
    @State var isLoggedIn: Bool

    var body: some View {
        if isLoggedIn {
            TabView {
                KlichLike()
//                SubmitView(userData: userData, klichStyle: .community)
                    .tag(0)
                    .tabItem { Label("Поиск", systemImage: "magnifyingglass") }

                SubmitView(userData: userData, klichStyle: .community)
                    .tag(1)
                    .tabItem { Label("Подать клич", systemImage: "plus.square.fill") }

                ProfileView(userData: userData)
                    .tag(2)
                    .tabItem { Label("Профиль", systemImage: "person.crop.circle.fill") }
            }
        } else {
            LoginView(userData: userData, isLoggedIn: $isLoggedIn)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        userData.userToken = "2f8547ced1e6405e68c534b926447c21"
        return ContentView(userData: userData, isLoggedIn: false)
    }
}
