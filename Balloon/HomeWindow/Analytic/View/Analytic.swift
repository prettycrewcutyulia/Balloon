//
//  Analytic.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 17.12.2023.
//

import SwiftUI
import Charts

struct Analytic: View {
    @ObservedObject var viewModel = AnalyticViewModel()
    var notes: [DiabetNote] { viewModel.getNote() }

    var body: some View {
        ScrollView {
            chartForPeriod(period: "Day", data: filterDataForDay())
                .frame(height: 300)
                .padding()
            chartForPeriod(period: "Week", data: filterDataForWeek())
                .frame(height: 300)
                .padding()
            chartForPeriod(period: "Month", data: filterDataForMonth())
                .frame(height: 300)
                .padding()
        }
    }

    func chartForPeriod(period: String, data: [DiabetNote]) -> some View {
        let averageSugar = calculateAverageSugar(data: data)
        return VStack {
            Chart(data) { note in
                LineMark(
                    x: .value("Date", note.date!),
                    y: .value("Blood", note.blood)
                )
                PointMark(
                    x: .value("Date", note.date!),
                    y: .value("Blood", note.blood)
                ).annotation(position: .overlay, alignment: .bottom, spacing: 10) {
                    Text("\(String(format: "%.1f", note.blood))")
                        .font(.caption)
                }
            }
            .frame(height: 300)
            .padding()
            .chartYScale(domain: 0...36)
        }
        .overlay(
            Text("\(period) Chart - Avg Sugar: \(String(format: "%.1f", averageSugar))")
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(8)
            , alignment: .topLeading
        )
    }
    
    func calculateAverageSugar(data: [DiabetNote]) -> Double {
            guard !data.isEmpty else { return 0 }
            let sum = data.reduce(0.0) { $0 + $1.blood }
            return sum / Double(data.count)
        }

    func filterDataForDay() -> [DiabetNote] {
        // Фильтрация данных за день
        // Например, использование текущей даты для фильтрации
        let currentDate = Date() // Получение текущей даты
        let filteredData = notes.filter { note in
            // Реализуйте логику фильтрации для дня здесь
            // Например, сравнение даты заметки с текущей датой
            return Calendar.current.isDate(note.date!, inSameDayAs: currentDate)
        }
        return filteredData
    }

    func filterDataForWeek() -> [DiabetNote] {
        // Фильтрация данных за неделю
        // Реализуйте логику фильтрации для недели аналогично дню,
        // но с учетом интервала недели вместо дня
        // Примерно как использование текущей недели для фильтрации
        let currentDate = Date() // Получение текущей даты
        let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
        let endOfWeek = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: startOfWeek)!
        let filteredData = notes.filter { note in
            return note.date! >= startOfWeek && note.date! < endOfWeek
        }
        return filteredData
    }

    func filterDataForMonth() -> [DiabetNote] {
        // Фильтрация данных за месяц
        // Реализуйте логику фильтрации для месяца аналогично дню и неделе
        // Примерно как использование текущего месяца для фильтрации
        let currentDate = Date() // Получение текущей даты
        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: currentDate))!
        let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        let filteredData = notes.filter { note in
            return note.date! >= startOfMonth && note.date! <= endOfMonth
        }
        return filteredData
    }
}


#Preview {
    Analytic()
}
