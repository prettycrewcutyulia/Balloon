//
//  FormNavigationBarViewModel.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 12.12.2023.
//

import Foundation

class FormNavigationBarViewModel :ObservableObject {
    @Published var choosenIndicators:DiabetiIndicators = DiabetiIndicators.Blood
    @Published var date:Date = Date.now
    @Published var blood:Double = 0.0
    @Published var XE:Double = 0.0
    @Published var shortInsulin: Double = 0.0
    @Published var longInsulin: Double = 0.0
    @Published var mood: String = "calm"
    
}
