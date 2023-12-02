//
//  AuthenticationService.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 01.12.2023.
//

import FirebaseAuth

class AuthenticationServiceEmail {
    static let shared = AuthenticationServiceEmail()
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            completion(error)
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            completion(error)
        }
    }
    
    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset (withEmail: email) { error in
            completion(error)
        }
    }
}
