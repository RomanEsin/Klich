//
//  ProfileView.swift
//  Klich
//
//  Created by Роман Есин on 22.05.2021.
//

import SwiftUI

struct ProfileView: View {

    @Binding var userToken: String

    var body: some View {
        Text("Hello, World!")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userToken: .constant(""))
    }
}
