//
//  FormNavigationBar.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 10.12.2023.
//

import SwiftUI
import UIKit

struct FormNavigationBar: View {
    
    var actionButton: ()->Void
    var textButton:String
    
    @StateObject var viewModel = FormNavigationBarViewModel.shared
    
    init(textButton:String, actionButton: @escaping ()->Void) {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("BaseColor"))
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(selectedTextAttributes, for: .selected)
        self.actionButton = actionButton
        self.textButton = textButton
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            Text(viewModel.choosenIndicators.rawValue.localized).font(.title2)
            Divider().frame(height: 1).background(Color("BaseColor")).padding(.horizontal)
            
            DatePicker("DateTime", selection: $viewModel.diabetNote.Date).labelsHidden().padding(.bottom) .environment(\.locale, UserDefaults.standard.string(forKey: "selectedLanguage") == "ru" ? Locale(identifier: "ru_RU"): Locale.autoupdatingCurrent) // Установка локали на русскую, если необходимо

            switch viewModel.choosenIndicators {
            case .Blood:
                CustomCircleSlider(count: $viewModel.diabetNote.Blood, measurement: "mmol/l", koef: 36).padding()
            case .XE:
                CustomCircleSlider(count: $viewModel.diabetNote.XE, measurement: "bu", koef: 25).padding()
                
            case .ShortInsulin:
                CustomCircleSlider(count: $viewModel.diabetNote.ShortInsulin, measurement: "units", koef: 30).padding()
                
            case .LongInsulin:
                CustomCircleSlider(count: $viewModel.diabetNote.LongInsulin, measurement: "units", koef: 100).padding()
                
            case .Comment:
                TextEditorComment(comment: $viewModel.diabetNote.Comment)
                    .font(.body)
                    .frame(height: UIScreen.main.bounds.width - 150, alignment: .leading)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BaseColor"), lineWidth: 1)).padding()
                
            }
            
            Button(action: {
                actionButton()
                viewModel.choosenIndicators = .Blood
                viewModel.isModalPresented = false 
            }, label: {Text(textButton) .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width * 0.3)
                    .background(Color("BaseColor"))
                .cornerRadius(10)}).buttonStyle(PlainButtonStyle()).padding()
            Picker("DiabetiIndicators", selection: $viewModel.choosenIndicators) {
                ForEach(DiabetiIndicators.allCases, id: \.self) { indicator in
                    switch indicator {
                    case .Blood:
                        Image(systemName: "drop.fill").tag(indicator)
                    case .XE:
                        Image(systemName:"fork.knife").tag(indicator)
                    case .ShortInsulin:
                        Image(systemName:"syringe").tag(indicator)
                    case .LongInsulin:
                        Image(systemName: "syringe.fill").tag(indicator)
                    case .Comment:
                        Image(systemName: "square.and.pencil").tag(indicator)
                    }
                }
            }.pickerStyle(.segmented)
                .padding(.horizontal)
        }.padding()
    }
}

#Preview {
    FormNavigationBar(textButton: "Save", actionButton: {})
}
