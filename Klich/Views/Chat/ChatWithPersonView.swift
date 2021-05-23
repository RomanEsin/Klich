//
//  ChatWithPersonView.swift
//  Klich
//
//  Created by Роман Есин on 23.05.2021.
//

import SwiftUI

struct MessageView: View {

    let message: String

    var body: some View {
        Text(message)
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(12)
    }
}

struct ChatWithPersonView: View {

    @State var messages = [
        "Привет",
        "Что делаешь?",
        "Привет, когда придешь на работу???"
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .opacity(0)
                ForEach(messages, id: \.self) { msg in
                    MessageView(message: msg)
                }
            }
            .padding(.horizontal)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Чат")
    }
}

struct ChatWithPersonView_Previews: PreviewProvider {
    static var previews: some View {
        ChatWithPersonView()
    }
}
