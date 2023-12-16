//
//  CustomRow.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 16.12.2023.
//

import SwiftUI

struct CustomRow: View {
    var note: DiabetNote

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(formattedDate(note.date!))").foregroundStyle(Color("TextColor"))
            HStack(content: {
                Image(systemName: "drop.fill")
                Text(String(format: "%.1f", note.blood)).foregroundStyle(Color("TextColor"))
                Image(systemName:"fork.knife")
                Text(String(format: "%.1f", note.xe)).foregroundStyle(Color("TextColor"))
                Image(systemName:"syringe")
                Text(String(format: "%.1f", note.shortInsulin)).foregroundStyle(Color("TextColor"))
                Image(systemName: "syringe.fill")
                Text(String(format: "%.1f", note.longInsulin)).foregroundStyle(Color("TextColor"))
            }).foregroundStyle(Color("BaseColor"))
            HStack(alignment: .top) {
                Image(systemName: "square.and.pencil").foregroundStyle(Color("BaseColor"))
                Text(note.comment ?? "")
            }
        }
    }
    // Метод для форматирования даты и времени
        func formattedDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "ru_RU")
            return dateFormatter.string(from: date)
        }
}
