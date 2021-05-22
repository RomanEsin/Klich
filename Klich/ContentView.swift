//
//  ContentView.swift
//  Klich
//
//  Created by Роман Есин on 22.05.2021.
//

import SwiftUI

class UserDefaultsManager {
    static var shared = UserDefaultsManager()

    private init() {}
}

struct ContentView: View {

    @State var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            Text("You logged in!")
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
