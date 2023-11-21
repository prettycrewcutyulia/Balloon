//
//  HelloView.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 19.11.2023.
//

import SwiftUI

struct HelloView: View {
    let userName =  UserDefaults.standard.string(forKey: "userName") ?? "Non"
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        VStack(spacing: 40) {
                VStack(spacing: 30, content: {
                    Text("Hi".localized + ", " + userName + ", " + "my name is Balloon and I will become your personal diabetic assistant".localized).padding(18).font(Font.custom("OpenSans-Regular", size: 25)).lineSpacing(-1).tracking(-1).multilineTextAlignment(.center)
                    Image("balloon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 223)
                    Text("Answer a couple of questions before I can help you".localized).padding(30).font(Font.custom("OpenSans-Regular", size: 25)).lineSpacing(-1).tracking(-1).multilineTextAlignment(.center)
                })
            NavigationLink {
//                AuthorizationView()
            } label: {
                    Text("Let's go".localized).font(Font.custom("OpenSans-SemiBold", size: 25)).foregroundColor(.white)
                        .frame(width: screenSize.width * 0.9, height: 70)
                        .background(Color(red: 58 / 255.0, green: 130 / 255.0, blue: 247 / 255.0))
                        .cornerRadius(10)
            }
        }
    }
}

#Preview {
    HelloView()
}
