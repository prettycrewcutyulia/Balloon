//
//  ForgotPasswordView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 19.11.2023.
//

import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State var email = ""
    @State var showAlert = false // Добавлено состояние для отображения Alert
    @State private var alertMessage = ""
    @State private var alertText = ""
    @State private var success = false
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        VStack(spacing: 30) {
            VStack(alignment: .center ,spacing: 6, content: {
                Image("balloon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140)
                Text("Recover Password".localized).font(Font.custom("OpenSans-Regular", size: 30)).foregroundStyle(.black).frame(height: 45)
            })
                VStack(alignment: .leading, spacing: 20, content: {
                    TextField("Email".localized, text: $email) .frame(width: screenSize.width * 0.8, height: 24).padding(.vertical, 18).padding(.horizontal).font(Font.custom("OpenSans-Regular", size: 20)).overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))).multilineTextAlignment(.leading).autocapitalization(.none)
                })
            Button(action: {
                if (email != "") {
                    Auth.auth().sendPasswordReset (withEmail: self.email) { (error) in
                        if error == nil {
                            self.showAlert = true
                            self.success = true
                            self.alertText = "Success".localized
                            self.alertMessage = "Password reset email has been sent to".localized + "\(self.email)"
                        } else {
                            self.showAlert = true
                            self.alertText = "Not success".localized
                            self.alertMessage = "Something went wrong. Try again.".localized
                        }
                    }
                }
            }) {
                Text("Recover Password".localized).font(Font.custom("OpenSans-SemiBold", size: 25)).foregroundColor(.white)
                    .frame(width: screenSize.width * 0.9, height: 70)
                    .background(Color(red: 58 / 255.0, green: 130 / 255.0, blue: 247 / 255.0))
                    .cornerRadius(10)
            }.alert(isPresented: $showAlert) {
                Alert(title: Text(alertText), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }.navigationTitle("")
    }
}
