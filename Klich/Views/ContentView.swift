//
//  ContentView.swift
//  Klich
//
//  Created by Роман Есин on 22.05.2021.
//

import SwiftUI

struct ContentView: View {

    @State var userToken: String
    @State var isLoggedIn: Bool

    var body: some View {
        if isLoggedIn {
            TabView {
                ProfileView(userToken: $userToken)
            }
        } else {
            LoginView(userToken: $userToken, isLoggedIn: $isLoggedIn)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userToken: "2f8547ced1e6405e68c534b926447c21", isLoggedIn: false)
    }
}
