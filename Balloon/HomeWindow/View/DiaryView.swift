//
//  DiaryView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 15.12.2023.
//

import SwiftUI

struct DiaryView: View {
    @ObservedObject var viewModel = FormNavigationBarViewModel()
    
    var body: some View {
        ZStack() {
//            ScrollView {
//                FormNavigationBar(textButton: "Save".localized, actionButton: viewModel.saveNote).listRowSeparator(.hidden)
                List {
                    FormNavigationBar(textButton: "Save".localized, actionButton: viewModel.saveNote).listRowSeparator(.hidden)
                    Section("History".localized) {
                        ForEach(viewModel.notes.reversed(), id: \.self) { item in
                            Text(item.comment!)
                                .onTapGesture {
                                    viewModel.isModalPresented.toggle()
                                }
                        }.onDelete { indexSet in
                            //contacts.remove(atOffsets: indexSet)

                        }
                    }.onAppear(perform: {
                        viewModel.getNote()
                    })
                }.listStyle(.plain)
//            }
            if viewModel.isModalPresented {
                Color.black.opacity(0.5)
                                 .edgesIgnoringSafeArea(.all)
                                 .blur(radius: 5)
                CenteredModalView(isModalPresented: $viewModel.isModalPresented, action: viewModel.updateNote)
            }
        }
    }
}

struct CenteredModalView: View {
    @Binding var isModalPresented: Bool
    var action: () -> Void
    
    init(isModalPresented: Binding<Bool>, action: @escaping () -> Void) {
        _isModalPresented = isModalPresented
        self.action = action
    }

    var body: some View {
        VStack {
            FormNavigationBar(textButton: "Update".localized, actionButton: action)
            Button("Cancel".localized) {
                // Закрываем модальное окно
                self.isModalPresented.toggle()
            }.foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width * 0.3)
                .background(Color("BaseColor"))
            .cornerRadius(10).padding()
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding()
    }
}

#Preview {
    DiaryView()
}
