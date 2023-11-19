//
//  ContentView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 17.11.2023.
//

import SwiftUI

struct ChooseLanguageView: View {
    
    @State private var selectedLanguage: String = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
    
    @State private var isContinue: Bool = false
    
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        NavigationView {
            VStack {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,spacing: 32, content: {
                    Image("balloon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140)
                    Text(LocalizedStringKey("choose_language".localized)).font(Font.custom("OpenSans-Regular", size: 30))
                })
                Spacer(minLength: 97)
                VStack(alignment: .leading,spacing: 10, content: {
                    Button (action: {
                        selectedLanguage = "en"
                        UserDefaults.standard.set("en", forKey: "selectedLanguage")
                    }, label: {
                        Label("english".localized, systemImage: selectedLanguage == "en" ? "largecircle.fill.circle" : "circle").font(Font.custom("OpenSans-Regular", size: 25)).foregroundColor(.black)
                    }).padding(.vertical, 12).padding(.horizontal, 20)
                    Button (action: {
                        selectedLanguage = "ru"
                        UserDefaults.standard.set("ru", forKey: "selectedLanguage")
                    }, label: {
                        Label("russian".localized, systemImage: selectedLanguage == "ru" ? "largecircle.fill.circle" : "circle").font(Font.custom("OpenSans-Regular", size: 25)).foregroundColor(.black)
                    }).padding(.vertical, 12).padding(.horizontal, 20)
                }
                )
                Spacer(minLength: 230)
                NavigationLink {
                    AuthorizationView()
                } label: {
                        Text("continue".localized).font(Font.custom("OpenSans-SemiBold", size: 25)).foregroundColor(.white)
                            .frame(width: screenSize.width * 0.9, height: 70)
                            .background(Color(red: 58 / 255.0, green: 130 / 255.0, blue: 247 / 255.0))
                            .cornerRadius(10)
                }
            }.navigationTitle("")
        }
    }
}

#Preview {
    ChooseLanguageView()
}
