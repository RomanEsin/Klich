//
//  SearchView.swift
//  Klich
//
//  Created by Роман Есин on 23.05.2021.
//

import SwiftUI

struct SearchView: View {

    @State var searchText = ""

    var body: some View {
        VStack {
            TextField("Поиск", text: $searchText)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
