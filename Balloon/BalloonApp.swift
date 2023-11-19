//
//  BalloonApp.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 17.11.2023.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import FirebaseAppCheck

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    let providerFactory = AppCheckDebugProviderFactory()
//    AppCheck.setAppCheckProviderFactory(providerFactory)
    FirebaseApp.configure()
    return true
  }
}

@main
struct BalloonApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ChooseLanguageView()
        }
    }
}
