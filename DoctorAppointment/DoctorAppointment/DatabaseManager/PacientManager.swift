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
        do {
            try db.collection("Pacient").document(pacient.email).setData(from: pacient)
            completion(true)
        } catch let error {
            print("Error writing pacient to Firestore: \(error)")
            completion(false)
        }
        
        
        
    }
    
}



