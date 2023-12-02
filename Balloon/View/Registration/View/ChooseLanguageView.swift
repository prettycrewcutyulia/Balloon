//
//  ContentView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 17.11.2023.
//

import SwiftUI

struct ChooseLanguageView: View {
    
    @ObservedObject var viewModel = ChooseLanguageViewModel()
    var text:String = "choose_language"
    
    var body: some View {
        NavigationView {
            VStack {
                TopImageWithText(Spacing: 32, Image: "balloon", Text: "choose_language".localized)
                Spacer(minLength: 97)
                VStack(alignment: .leading,spacing: 10, content: {
                    RadioButton(isSelected: viewModel.selectedLanguage == "en", text: "english", action:{ viewModel.chooseLanguage("en")})
                    RadioButton(isSelected: viewModel.selectedLanguage == "ru", text: "russian", action:{ viewModel.chooseLanguage("ru")})
                })
                Spacer(minLength: 230)
                CustomNavigationButton(destination: AuthorizationView(), title:""){
                    Text("continue".localized)}
            }.navigationTitle("")
        }
    }
}
