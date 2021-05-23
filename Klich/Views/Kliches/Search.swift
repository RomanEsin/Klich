//
//  Search.swift
//  Klich
//
//  Created by Роман Есин on 23.05.2021.
//

import SwiftUI

struct Search: View {

    @Binding var selectedTab: Int

    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink("Поиск", destination: KlichLike(selectedTab: $selectedTab))
                }

                NavigationLink("Сообщества", destination: KlichLike(selectedTab: $selectedTab))
                NavigationLink("Помощь", destination: KlichLike(selectedTab: $selectedTab))
                NavigationLink("Проекты", destination: KlichLike(selectedTab: $selectedTab))
                NavigationLink("Поиск соседа", destination: KlichLike(selectedTab: $selectedTab))
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Поиск")
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search(selectedTab: .constant(1))
    }
}
