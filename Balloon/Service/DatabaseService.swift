//
//  DatabaseService.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 08.12.2023.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    static let shared = DatabaseService()
    
    private init(){}
    
    private let database = Firestore.firestore()
    
    private var userPath: CollectionReference {
        return database.collection("users")
    }
    
    func addUser(user:UserGeneralInfo, completion: @escaping (Error?) -> Void) {
        do {
            try userPath.addDocument(from: user)
        } catch {
            completion(error)
        }
        completion(nil)
    }
    
    func updateUser(user: UserGeneralInfo, completion: @escaping (Error?) -> Void) {
        // в процессе
    }
    
    func getUser(userID: String, completion: @escaping (Result<UserGeneralInfo, Error>) -> Void) {
        // в процессе
    }

}
struct UserGeneralInfoToSend: Codable {
    var id : String
    var name: String
    var birthDate: String // Отправляйте дату в строковом формате, который может быть преобразован на сервере в DateTime
    var typeDiabet: String
    var height: Int
    var weight: Int
    var male: String
}
