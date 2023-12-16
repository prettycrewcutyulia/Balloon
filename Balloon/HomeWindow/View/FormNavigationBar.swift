//
//  FormNavigationBar.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 10.12.2023.
//

import SwiftUI

enum DiabetiIndicators: String, CaseIterable, Identifiable {
    case Blood = "Blood"
    case XE = "Bread unit"
    case ShortInsulin = "Short insulin"
    case LongInsulin = "Long insulin"
    case Comment = "Comment"
    
    var id: String { self.rawValue }
}

struct FormNavigationBar: View {
    var actionButton: ()->Void
    var textButton:String
    @ObservedObject var viewModel = FormNavigationBarViewModel()
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
            
            DatePicker("DateTime", selection: $viewModel.diabetNote.Date).labelsHidden().padding(.bottom)
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
            
            Button(action: {actionButton()}, label: {Text(textButton) .foregroundColor(.white)
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

struct TextEditorComment:View {
    enum Field {
        case textEditor
    }
    @Binding var comment:String
    @FocusState private var focusedField: Field?
    var placeholder:String = "Enter your notes..."
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            if comment.isEmpty  {
                VStack {
                    TextField(placeholder, text: $comment)
                        .padding(.leading, 6)
                        .padding(.top, 8)
                    Spacer()
                }
            } else {
                TextEditor(text: $comment).focused($focusedField, equals: .textEditor)
                    .onAppear {
                        focusedField = .textEditor
                    }
            }
        }
    }
}


struct CustomCircleSlider :View {
    private var widthCircle:CGFloat = 40
    @State var size: CGFloat = UIScreen.main.bounds.width - 150
    @State var progress:CGFloat = 0
    @State var angle:Double = 0
    @Binding var count:Double
    @State var measurement:String
    @State var koef:Double
    @State var format:String = "%.1f"
    
    init(count: Binding<Double>, measurement: String, koef: Double, format:String = "%.1f") {
        self.measurement = measurement
        self.koef = koef
        self.format = format
        self._count = count
    }
    
    var body: some View {
        ZStack {
            Circle().stroke(.gray, style: StrokeStyle(lineWidth: widthCircle, lineCap: .round, lineJoin: .round)).frame(width: size, height: size).rotationEffect(.init(degrees: -90))
            
            // progress
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color("BaseColor"), style: StrokeStyle(lineWidth: widthCircle, lineCap: .butt, lineJoin: .round))
                .frame(width: size, height: size).rotationEffect(.init(degrees: -90))
            Circle()
                .fill(.gray)
                .frame(width: widthCircle, height: widthCircle)
                .offset(x: size / 2)
                .rotationEffect(.init(degrees: -90))
            
            Circle().fill(Color.white).frame(width: widthCircle, height: widthCircle).offset(x: size / 2)
                .rotationEffect(.init(degrees: angle))
                .gesture(DragGesture().onChanged(onDrag(value:)))
                .rotationEffect(.init(degrees: -90))
            Text(String(format: format, progress * koef) + " " + measurement)
                .font(.title)
                .fontWeight(.medium)
        }.onAppear {
            progress = count / koef
            angle = progress * 360
        }
    }
    
    func onDrag(value: DragGesture.Value) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radians = atan2(vector.dy - widthCircle/2, vector.dx - widthCircle/2)
        // converting to angle...
        var angle = radians * 180 / .pi
        if (angle < 0) {
            angle = 360 + angle
        }
        withAnimation(Animation.linear(duration: 0.15)) {
            let progress = angle / 360
            self.progress = progress
            self.angle = Double(angle)
            self.count = progress * koef
        }
    }
}

#Preview {
    FormNavigationBar(textButton: "Save", actionButton: {})
}
