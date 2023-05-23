//
//  PacientManager.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 07.04.2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseCore
import FirebaseFirestore

class PacientManager{
    static var shared = PacientManager()
    let db = Firestore.firestore()
    
    private init(){}
    
    func addPacient(pacient:Pacient, completion: @escaping (Bool) -> ()){
        print(pacient.email)
        do {
            try db.collection("Pacient").document(pacient.email).setData(from: pacient)
            completion(true)
        } catch let error {
            print("Error writing pacient to Firestore: \(error)")
            completion(false)
        }
        
    }
    
    func getPacientForEmail(email: String, completion: @escaping (Pacient?) -> () ){
        
        db.collection("Pacient").document(email).getDocument(as: Pacient.self) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                completion(nil)
                print("Error getting pacient \(failure)")
            }
            
        }
        
    }
    
}



