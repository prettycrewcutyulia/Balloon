//
//  FormNavigationBarViewModel.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 12.12.2023.
//

import Foundation


class FormNavigationBarViewModel :ObservableObject {
    @Published var choosenIndicators:DiabetiIndicators = DiabetiIndicators.Blood
    @Published var diabetNote:DiabetNoteModel = DiabetNoteModel(Date: .now, Blood: 0, XE: 0, ShortInsulin: 0, LongInsulin: 0, Comment: "")
    let coreDM: CoreDataManager = CoreDataManager.shared
    @Published var notes = [DiabetNote]()
    @Published var isModalPresented = false
    
    func getNote() {
        var fetchedNotes = coreDM.getAllNotes()
        self.notes = fetchedNotes
    }
    
    func saveNote() {
        // сохранение в CoreData
        coreDM.saveNote(note: diabetNote)
        // сохранение на серваке
        
        DispatchQueue.main.async {
            //очищение
            self.diabetNote = DiabetNoteModel(Date: .now, Blood: 0, XE: 0, ShortInsulin: 0, LongInsulin: 0, Comment: "")
        }
        getNote()
    }
    
    func updateNote() {
        isModalPresented.toggle()
    }
    
}
