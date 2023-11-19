//
//  AuthorizationView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 18.11.2023.
//

import Foundation
import SwiftUI
import FirebaseAuth
import GoogleSignIn

struct AuthorizationView: View {
    @State var user = ""
    @State var pass = ""
    @State var showInvalidError = false
    @State private var isContinue: Bool = false
    @State private var isForgotPassword: Bool = false
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size

            VStack(spacing: 30, content: {
                VStack(alignment: .center ,spacing: 6, content: {
                    Image("balloon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140)
                    Text(LocalizedStringKey("welcome".localized)).font(Font.custom("OpenSans-Regular", size: 30)).foregroundStyle(.black).frame(height: 45)
                })
                VStack(spacing: 15, content: {
                    VStack(alignment: .leading, spacing: 20, content: {
                        TextField("Email".localized, text: $user) .frame(width: screenSize.width * 0.8, height: 24).padding(.vertical, 18).padding(.horizontal).font(Font.custom("OpenSans-Regular", size: 20)).overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))).multilineTextAlignment(.leading).autocapitalization(.none)
                        SecureField("Password".localized, text: $pass) .frame(width: screenSize.width * 0.8, height: 24).padding(.vertical, 18).padding(.horizontal).font(Font.custom("OpenSans-Regular", size: 20)).overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))).multilineTextAlignment(.leading).autocapitalization(.none)
                    })
                        VStack(content: {
                            NavigationLink {
                                ForgotPasswordView()
                            } label: {Text("forgot_password".localized).font(Font.custom("OpenSans-Light", size: 16)).padding(.trailing, 20)
                        }.frame(maxWidth: .infinity, alignment: .trailing).foregroundStyle(Color.gray)
                            if (showInvalidError) {
                                Text("invalidloginpassword".localized).font(Font.custom("OpenSans-SemiBold", size: 16)).foregroundStyle(Color.red)
                            }
                            })
                        })
                Button(action: {
                    signIn(email: self.user , password: self.pass ) { error in
                        if let error = error {
                            showInvalidError = true
                            print("Ошибка входа: \(error)")
                        } else {
                            showInvalidError = false
                            UserDefaults.standard.set("yes", forKey: "login")
                            print("Пользователь успешно вошел")
                        }
                    }
                }) {
                    Text("sign in".localized).font(Font.custom("OpenSans-SemiBold", size: 25)).foregroundColor(.white)
                        .frame(width: screenSize.width * 0.9, height: 70)
                        .background(Color(red: 58 / 255.0, green: 130 / 255.0, blue: 247 / 255.0))
                        .cornerRadius(10)
                }
                HStack(content: {
                    Rectangle().frame( height: 1)
                    Text("or".localized)
                    Rectangle().frame( height: 1)
                }).padding(.horizontal, 20).foregroundStyle(.gray)
                HStack(spacing: 25, content: {
                    Button(action: {
                        
                    }, label: {
                        Image("google_logo").resizable().aspectRatio(contentMode: .fit).frame(width: 30,  height: 31.6).padding(15) .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                    })
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "apple.logo").resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 31.6).padding(15) .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))).foregroundStyle(Color.black)
                    })
                })
                HStack(content: {
                    Text("Don't have an account?".localized).font(Font.custom("OpenSans-Light", size: 18)).foregroundStyle(Color.gray)
                    NavigationLink {
                        RegistrationView()
                    } label: {
                        Text("Sign up".localized).font(Font.custom("OpenSans-SemiBold", size: 18)).foregroundStyle(Color.black)
                    }
                })
            }).navigationTitle("")
    }
}

func signIn(email: String, password: String, completion: @escaping (String?) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        if let error = error {
            completion(error.localizedDescription)
        } else {
            completion(nil)
        }
    }
}


#Preview {
    AuthorizationView()
}
