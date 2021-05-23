//
//  ChatView.swift
//  Klich
//
//  Created by Роман Есин on 23.05.2021.
//

import SwiftUI

struct ChatItem: View {
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .font(.title)
            VStack(alignment: .leading) {
                Text("Имя Организации или Человека")
                    .font(.body.bold())
                Text("Привет когда ты придешь на работу?")
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

struct ChatView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: ChatWithPersonView(),
                    label: {
                        ChatItem()
                    })
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Чаты")
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
