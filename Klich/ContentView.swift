//
//  ContentView.swift
//  Klich
//
//  Created by Роман Есин on 22.05.2021.
//

import SwiftUI

struct ContentView: View {

    @State var isLoggedIn: Bool

    var body: some View {
        if isLoggedIn {
            VStack {
                Text("You've logged in!")
                Button(action: {
                    isLoggedIn = false
                }, label: {
                    Text("Выйти из аккаунта")
                })
            }
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isLoggedIn: false)
    }
}
