//
//  KlichLike.swift
//  Klich
//
//  Created by Роман Есин on 23.05.2021.
//

import SwiftUI

struct KlichLike: View {

    @State var items: [KlichStyle] = [.communityCell, .communityCell2, .communityCell3]
    @State var currentKlich = KlichStyle.communityCell
    @State var translation = CGSize.zero
    @State var dismissLike = false
    @State var scale: CGFloat = 1

    @State var isMatch = false

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.system(size: 90))
                        .opacity( Double(translation.width) / 100)
                        .scaleEffect(min(translation.width / 120, 2))
                }

                Spacer()

                VStack {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 90))
                        .opacity(Double(-translation.width) / 100)
                        .scaleEffect(min(-translation.width / 120, 2))
                }
            }
            .padding(.horizontal)
            VStack {
                Text("Поиск Совпадений")
                    .font(.title3.bold())
                VStack {
                    Spacer()
                    Image(systemName: "person.3.fill")
                        .font(.system(size: 130))
                        .foregroundColor(.accentColor)
                    Spacer()

                    VStack(alignment: .leading, spacing: 32) {
                        Divider()
                        VStack(alignment: .leading) {
                            Text(currentKlich.quickSign)
                                .font(.title2.bold())
                            Text(currentKlich.quickSignDesc)
                                .foregroundColor(.secondary)
                                .padding(.bottom, 4)
                            HStack {
                                QuickSign(image: Image(systemName: "paperplane.fill"), enabled: false)
                                QuickSign(image: Image(systemName: "paperplane.fill"), enabled: false)
                                QuickSign(image: Image(systemName: "paperplane.fill"), enabled: false)
                                QuickSign(image: Image(systemName: "paperplane.fill"), enabled: false)
                                QuickSign(image: Image(systemName: "paperplane.fill"), enabled: false)
                            }
                        }

                        if let secT = currentKlich.secTitle,
                           let secD = currentKlich.secDescription {
                            VStack(alignment: .leading) {
                                Text(secT)
                                    .font(.title2.bold())
                                Text(secD)
                                    .foregroundColor(.secondary)
                                    .padding(.bottom, 4)
                            }
                        }

                        if let thT = currentKlich.thrdTitle,
                           let thD = currentKlich.thrdDescription {
                            VStack(alignment: .leading) {
                                Text(thT)
                                    .font(.title2.bold())
                                Text(thD)
                                    .foregroundColor(.secondary)
                                    .padding(.bottom, 4)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(32)
                .padding()

                .offset(translation)
                .rotationEffect(.degrees(Double(translation.width) / 15))
                .opacity(dismissLike ? 0 : 1)
                .scaleEffect(scale)

                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .global)
                        .onChanged { value in
                            withAnimation {
                                self.translation = value.translation
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                if abs(value.predictedEndTranslation.width) > UIScreen.main.bounds.width / 2 {
                                    if value.predictedEndTranslation.width > 0 {
                                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                                    } else {
                                        UINotificationFeedbackGenerator().notificationOccurred(.error)
                                    }

                                    self.dismissLike = true
                                    self.translation = value.predictedEndTranslation

                                    if Bool.random() && Bool.random() && value.predictedEndTranslation.width > 0 {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            isMatch = true
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                            self.scale = 0.8
                                            self.translation = .zero
                                            withAnimation(.spring()) {
                                                self.scale = 1
                                                self.dismissLike = false
                                            }
                                        }
                                    } else {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                            currentKlich = items.randomElement()!

                                            self.scale = 0.8
                                            self.translation = .zero
                                            withAnimation(.spring()) {
                                                self.scale = 1
                                                self.dismissLike = false
                                            }
                                        }
                                    }
                                } else {
                                    self.translation = .zero
                                }
                            }
                        }
                )
            }
            .onChange(of: isMatch, perform: { value in

            })
            .sheet(isPresented: $isMatch, content: {
                VStack {
                    Spacer()

                    Text("СОВПАДЕНИЕ")
                        .font(.largeTitle.bold())
                    Text(currentKlich.quickSign + " Готов поработать с вами!")
                        .font(.title)
                        .padding()

                    Spacer()

                    Button(action: {
                        isMatch = false
                    }, label: {
                        VStack {
                            Text("Связаться")
                                .font(.title3.bold())
                        }
                        .foregroundColor(.white)
                        .frame(height: 25)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.klichPurple)
                        .cornerRadius(16)
                    })
                    .padding()
                    .padding(.bottom, 70)
                }
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [Color.klichPurple.opacity(0.3), Color.klichPurple.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
            })
        }
    }
}

struct KlichLike_Previews: PreviewProvider {
    static var previews: some View {
        KlichLike()
    }
}
