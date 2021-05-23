//
//  SubmitView.swift
//  Klich
//
//  Created by Роман Есин on 23.05.2021.
//

import SwiftUI

struct QuickSign: View {
    var image: Image
    var enabled: Bool?
    @State var isEnabled = false

    var items = [
        Image(systemName: "paperplane.fill"),
        Image(systemName: "graduationcap.fill"),
        Image(systemName: "ruler.fill"),
        Image(systemName: "pianokeys.inverse"),
    ]

    var body: some View {
        Button(action: {
            isEnabled.toggle()
        }, label: {
            image
                .foregroundColor(isEnabled ? .accentColor : .secondary)
                .font(.title3)
                .padding(.horizontal, 4)
        })
        .disabled(!(enabled ?? true))
    }
}

struct KlichStyle {
    static var community = KlichStyle(
        quickSign: "Быстрые значки", quickSignDesc: "Выберите для отображения",
        secTitle: "Расскажи, что умеешь", secDescription: "Заполните это поле подробно, расскажите о себе что-нибудь интересное",
        thrdTitle: "Чего ждешь от работы", thrdDescription: "Перечисли и напиши подробно о каком соседе ты мечтаешь, что уважаешь, а что не переносишь"
    )

    static var help = KlichStyle(
        quickSign: "Быстрые значки", quickSignDesc: "Выберите для отображения",
        secTitle: "Расскажи, что умеешь", secDescription: "Заполните это поле подробно, расскажите о себе что-нибудь интересное",
        thrdTitle: nil, thrdDescription: nil
    )

    static var project = KlichStyle(
        quickSign: "Быстрые значки", quickSignDesc: "Выберите для отображения",
        secTitle: "Расскажи, что умеешь", secDescription: "Заполните это поле подробно, расскажите о себе что-нибудь интересное",
        thrdTitle: "Чего ждешь от работы", thrdDescription: "Перечисли и напиши подробно о каком соседе ты мечтаешь, что уважаешь, а что не переносишь"
    )

    static var friend = KlichStyle(
        quickSign: "Быстрые значки", quickSignDesc: "Выберите для отображения",
        secTitle: "Расскажи, что умеешь", secDescription: "Заполните это поле подробно, расскажите о себе что-нибудь интересное",
        thrdTitle: "Чего ждешь от работы", thrdDescription: "Перечисли и напиши подробно о каком соседе ты мечтаешь, что уважаешь, а что не переносишь"
    )

    static var communityCell = KlichStyle(
        quickSign: "Интернет журнал", quickSignDesc: "",
        secTitle: "Об организации", secDescription: "Университетский интернет-журнал с молодой и прогрессивной командой",
        thrdTitle: "Ищем", thrdDescription: "НАм нужны люди настоящего писательского мастерства"
    )

    static var communityCell2 = KlichStyle(
        quickSign: "Интернет журнал2", quickSignDesc: "",
        secTitle: "Об организации", secDescription: "Университетский интернет-журнал с молодой и прогрессивной командой",
        thrdTitle: "Ищем", thrdDescription: "НАм нужны люди настоящего писательского мастерства"
    )

    static var communityCell3 = KlichStyle(
        quickSign: "Интернет журнал3", quickSignDesc: "",
        secTitle: "Об организации", secDescription: "Университетский интернет-журнал с молодой и прогрессивной командой",
        thrdTitle: "Ищем", thrdDescription: "НАм нужны люди настоящего писательского мастерства"
    )

    let quickSign: String
    let quickSignDesc: String

    let secTitle: String?
    let secDescription: String?

    let thrdTitle: String?
    let thrdDescription: String?
}

struct SubmitView: View {

    @ObservedObject var userData: UserData
    var klichStyle: KlichStyle
    @State var isPublishOpened = false

    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.accentColor)
            Spacer()

            VStack(alignment: .leading, spacing: 32) {
                Divider()
                VStack(alignment: .leading) {
                    Text(klichStyle.quickSign)
                        .font(.title2.bold())
                    Text(klichStyle.quickSignDesc)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 4)
                    HStack {
                        QuickSign(image: Image(systemName: "paperplane.fill"))
                        QuickSign(image: Image(systemName: "paperplane.fill"))
                        QuickSign(image: Image(systemName: "paperplane.fill"))
                        QuickSign(image: Image(systemName: "paperplane.fill"))
                        QuickSign(image: Image(systemName: "paperplane.fill"))
                    }
                }

                if let secT = klichStyle.secTitle, let secD = klichStyle.secDescription {
                    VStack(alignment: .leading) {
                        Text(secT)
                            .font(.title2.bold())
                        Text(secD)
                            .foregroundColor(.secondary)
                            .padding(.bottom, 4)
                    }
                }

                if let thT = klichStyle.thrdTitle, let thD = klichStyle.thrdDescription {
                    VStack(alignment: .leading) {
                        Text(thT)
                            .font(.title2.bold())
                        Text(thD)
                            .foregroundColor(.secondary)
                            .padding(.bottom, 4)
                    }
                }

                Button(action: {
                    isPublishOpened = true
                }, label: {
                    VStack {
                        Text("Опубликовать")
                            .font(.title3.bold())
                    }
                    .foregroundColor(.white)
                    .frame(height: 25)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.klichPurple)
                    .cornerRadius(16)
                })
                .padding(.bottom, 60)
            }
            .padding(.horizontal)
            .sheet(isPresented: $isPublishOpened, content: {
                Text("Опубликовано")
            })
        }
    }
}

struct SubmitView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitView(userData: UserData(), klichStyle: .community)
    }
}
