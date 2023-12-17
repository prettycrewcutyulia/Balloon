//
//  DiaryView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 15.12.2023.
//

import SwiftUI

struct DiaryView: View {
    @ObservedObject var viewModel = FormNavigationBarViewModel.shared
    @State private var selectedIndex: Int? = nil
    private let updatedNote: DiabetNote? = nil
    @State private var needsRefresh: Bool = false
 
    var body: some View {
        ZStack() {
                VStack {
                    FormNavigationBar(textButton: "Save".localized, actionButton: viewModel.saveNote).listRowSeparator(.hidden)
                    List {
                        Section("History".localized) {
                            ForEach(viewModel.notes.indices.reversed(), id: \.self) { index in
                                CustomRow(note: viewModel.notes[index])
                                    .onTapGesture {
                                        viewModel.isModalPresented.toggle()
                                        selectedIndex = index
                                    }
                            }.onDelete(perform: { indexSet in
                                indexSet.forEach { index in
                                    let reversedIndex = viewModel.notes.indices.reversed()[index]
                                    viewModel.deleteNote(index: reversedIndex)
                                }
                            })
        
                        }
                    }.listStyle(.plain)
                        .refreshable {
                            viewModel.getNote()
                            print(viewModel.notes.first!.blood)
                                    }
                       
                }.onAppear(perform: {
                    viewModel.getNote()
                }).onChange(of: needsRefresh, {
                    viewModel.getNote()
                })
            if viewModel.isModalPresented {
                Color.black.opacity(0.5)
                                 .edgesIgnoringSafeArea(.all)
                                 .blur(radius: 5)
                UpdateNoteView(isModalPresented: $viewModel.isModalPresented, action: self.viewModel.getNote, updatedNote: viewModel.notes[selectedIndex!], needRefresh: $needsRefresh)
                
            }
        }
    }
}

