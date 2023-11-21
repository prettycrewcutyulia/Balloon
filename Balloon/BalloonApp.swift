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
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    let providerFactory = AppCheckDebugProviderFactory()
//    AppCheck.setAppCheckProviderFactory(providerFactory)
    FirebaseApp.configure()
    Auth.auth().useEmulator(withHost: "localhost", port: 9099)
    return true
  }
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
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
