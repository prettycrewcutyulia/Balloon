//
//  File.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 16.12.2023.
//

import Foundation
import SwiftUI

class UpdateNoteViewModel:ObservableObject {
//    @Binding var isModalPresented: Bool
    let coreDM: CoreDataManager = CoreDataManager.shared
    @ObservedObject var viewModelDiaryView:FormNavigationBarViewModel = FormNavigationBarViewModel.shared
    let updatedNote: DiabetNote
    
    
    init(viewModelDiaryView: FormNavigationBarViewModel = FormNavigationBarViewModel.shared, updatedNote:DiabetNote) {
        self.viewModelDiaryView = viewModelDiaryView
        self.updatedNote = updatedNote
    }
    
    func updateNote() {
        updatedNote.blood = viewModelDiaryView.diabetNote.Blood
        updatedNote.xe = viewModelDiaryView.diabetNote.XE
        viewModelDiaryView.coreDM.updateNote()
        DispatchQueue.main.async {
            //очищение
            self.viewModelDiaryView.diabetNote = DiabetNoteModel(Date: .now, Blood: 0, XE: 0, ShortInsulin: 0, LongInsulin: 0, Comment: "")
        }
        viewModelDiaryView.getNote()
    }
}
