//
//  ProfileView.swift
//  Klich
//
//  Created by Роман Есин on 22.05.2021.
//

import SwiftUI

class UserData: ObservableObject {
    @Published var user: User?
    @Published var userToken: String?
    @Published var categories: [Category] = []
}

struct ProfileView: View {

    @ObservedObject var userData: UserData
    @State var fullName = ""
    @State var about = ""

    @State var isLoadingData = true

    var body: some View {
        NavigationView {
            if !isLoadingData {
                ScrollView {
                    VStack {
                        Button {
                            print(123)
                        } label: {
                            Image(systemName: "person.crop.circle.fill.badge.plus")
                                .font(.system(size: 100))
                                .foregroundColor(.accentColor)
                                .padding(.top, 32)
                                .onAppear {
                                    
                                }
                        }


                        TextField("Имя Пользователя", text: $fullName) { _ in

                        } onCommit: {
                            userData.user?.fullName = fullName

                            KlichAPI.updateUser(userData.user, token: userData.userToken ?? "") { result in
                                switch result {
                                case .failure(let error):
                                    print(error.localizedDescription)
                                case .success(let user):
                                    DispatchQueue.main.async {
                                        userData.user = user
                                        self.fullName = userData.user?.fullName ?? ""
                                        self.about = userData.user?.about ?? ""
                                    }
                                }
                            }
                        }
                        .font(.title.bold())
                        .multilineTextAlignment(.center)

                        TextField("Расскажите о себе", text: $about) { _ in

                        } onCommit: {
                            userData.user?.about = about

                            KlichAPI.updateUser(userData.user, token: userData.userToken ?? "") { result in
                                switch result {
                                case .failure(let error):
                                    print(error.localizedDescription)
                                case .success(let user):
                                    DispatchQueue.main.async {
                                        userData.user = user
                                        self.fullName = userData.user?.fullName ?? ""
                                        self.about = userData.user?.about ?? ""
                                    }
                                }
                            }
                        }
                        .font(.title3.bold())
                        .multilineTextAlignment(.center)

                        VStack(alignment: .leading, spacing: 16) {
                            HStack(spacing: 0) {
                                Text("Имя Пользователя: ")
                                    .foregroundColor(.secondary)
                                Text("@")
                                    .foregroundColor(.accentColor)
                                Text(userData.user?.username ?? "?")
                            }

                            if !userData.categories.isEmpty {
                                Divider()

                                Text("Мои Категории:")
                                    .foregroundColor(.secondary)
                                ForEach(userData.categories) { category in
                                    HStack {
                                        Image(systemName: "circlebadge.fill")
                                            .foregroundColor(.accentColor)
                                        Text(category.name)
                                    }
                                }
                                .padding(.leading)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(16)
                        .padding(.top)
                        .padding(.horizontal)
                    }
                }
                .navigationTitle("Профиль")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                ProgressView()
                    .onAppear {
                        KlichAPI.getProfile(token: userData.userToken ?? "") { result in
                            isLoadingData = false
                            switch result {
                            case .failure(let error):
                                print(error.localizedDescription)
                            case .success(let user):
                                DispatchQueue.main.async {
                                    userData.user = user
                                    self.fullName = userData.user?.fullName ?? ""
                                    self.about = userData.user?.about ?? ""
                                }
                            }
                        }

                        KlichAPI.getMyCategories(token: userData.userToken ?? "") { result in
                            switch result {
                            case .failure(let error):
                                print(error.localizedDescription)
                            case .success(let cats):
                                DispatchQueue.main.async {
                                    withAnimation(.spring()) {
                                        userData.categories = cats
                                    }
                                }
                                print(cats)
                            }
                        }
                    }
                    .navigationTitle("Профиль")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        userData.user = User(username: "romanesin", password: "password", userType: 0, fullName: "Роман Есин")
        userData.userToken = "2f8547ced1e6405e68c534b926447c21"
        return ProfileView(userData: userData)
    }
}
