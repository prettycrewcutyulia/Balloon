//
//  DiabetNote.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 15.12.2023.
//
//
import Foundation


struct DiabetNoteModel: Codable {
    var Date:Date
    var Blood:Double
    var XE:Double
    var ShortInsulin: Double
    var LongInsulin: Double
    var Comment:String
}

extension DiabetNote {
    func toDiabetNoteModel() -> DiabetNoteModel {
        // Предполагая, что DiabetNoteModel - это структура или класс,
        // имеющая аналогичные свойства DiabetNote.
        return DiabetNoteModel(
            Date: self.date!,
            Blood: self.blood,
            XE: self.xe,
            ShortInsulin: self.shortInsulin,
            LongInsulin: self.longInsulin,
            Comment: self.comment!
        )
    }
}

extension Array where Element == DiabetNote {
    func toDiabetNoteModels() -> [DiabetNoteModel] {
        return self.map { $0.toDiabetNoteModel() }
    }
}
