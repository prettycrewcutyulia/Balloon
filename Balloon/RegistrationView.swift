//
//  RegistrationView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 19.11.2023.
//

import SwiftUI
import FirebaseAuth

struct RegistrationView: View {
    @State var userName = ""
    @State var email = ""
    @State var pass = ""
    @State var confirmPassword = ""
    @State var showInvalidError = false
    @State private var isContinue: Bool = false
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,spacing: 50, content: {
            VStack(alignment: .center ,spacing: 6, content: {
                Image("balloon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140)
                Text(LocalizedStringKey("started".localized)).font(Font.custom("OpenSans-Regular", size: 30)).foregroundStyle(.black).frame(height: 45)
            })
            VStack(alignment: .leading, spacing: 20, content: {
                TextField("User name".localized, text: $userName) .frame(width: screenSize.width * 0.8, height: 24).padding(.vertical, 18).padding(.horizontal).font(Font.custom("OpenSans-Regular", size: 20)).overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))).multilineTextAlignment(.leading)
                TextField("Email".localized, text: $email) .frame(width: screenSize.width * 0.8, height: 24).padding(.vertical, 18).padding(.horizontal).font(Font.custom("OpenSans-Regular", size: 20)).overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))).multilineTextAlignment(.leading) .autocapitalization(.none)
                SecureField("Password".localized, text: $pass) .frame(width: screenSize.width * 0.8, height: 24).padding(.vertical, 18).padding(.horizontal).font(Font.custom("OpenSans-Regular", size: 20)).overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))).multilineTextAlignment(.leading).autocapitalization(.none)
                SecureField("Confirm password".localized, text: $confirmPassword, onCommit: {
                    updateInvalidError()
                }).frame(width: screenSize.width * 0.8, height: 24).padding(.vertical, 18).padding(.horizontal).font(Font.custom("OpenSans-Regular", size: 20)).overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))).multilineTextAlignment(.leading).autocapitalization(.none)
                if (showInvalidError) {
                    Text("invalidconfirmpassword".localized).font(Font.custom("OpenSans-SemiBold", size: 16)).foregroundStyle(Color.red)
                }
                if (pass.count < 6) {
                    Text("The password length must be greater than or equal to 6".localized).font(Font.custom("OpenSans-SemiBold", size: 16)).foregroundStyle(Color.red)
                }
            })
            Button(action: {
                signUp(email: self.email , password: self.pass ) { error in
                    if let error = error {
                        showInvalidError = true
                        print("Ошибка входа: \(error)")
                    } else {
                        showInvalidError = false
                        UserDefaults.standard.set("yes", forKey: "login")
                        print("Пользователь успешно вошел")
                        UserDefaults.standard.set(userName, forKey: "userName")
                        isContinue = true
                    }
                }
            }) {
                Text("Sign up".localized).font(Font.custom("OpenSans-SemiBold", size: 25)).foregroundColor(.white)
                    .frame(width: screenSize.width * 0.9, height: 70)
                    .background(Color(red: 58 / 255.0, green: 130 / 255.0, blue: 247 / 255.0))
                    .cornerRadius(10)
            }.padding(.bottom, 20).fullScreenCover(isPresented: $isContinue, content: {
                HelloView()
            })
        }).navigationTitle("")
    }
    private func updateInvalidError() {
            showInvalidError = pass != confirmPassword
        }
}

func signUp(email: String, password: String, completion: @escaping (String?) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        if let error = error {
            completion(error.localizedDescription)
        } else {
            completion(nil)
        }
    }
}
