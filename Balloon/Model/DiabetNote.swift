//
//  DiabetNote.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 15.12.2023.
//

import Foundation


struct DiabetNote: Codable {
    var Date:Date
    var Blood:Double
    var XE:Double
    var ShortInsulin: Double
    var LongInsulin: Double
    var comment:String
}
