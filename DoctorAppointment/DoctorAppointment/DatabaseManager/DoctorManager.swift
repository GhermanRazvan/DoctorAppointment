//
//  DoctorManager.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 03.04.2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class DoctorManager {
    
    static let shared = DoctorManager()
    let db = Firestore.firestore()
    
    private init(){}
    
    func getAllDoctors(completion: @escaping (Result<[Doctor], Error>) -> () ) -> Void{
        var doctors: [Doctor] = []
        db.collection("Doctor").getDocuments { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            }
            else {
                for document in snapshot!.documents{
                    
                    let result = Result{
                        try document.data(as: Doctor.self)
                        
                    }
                    switch result{
                    case .success(let item):
                        doctors.append(item)
                    case .failure(let err):
                        completion(.failure(err))
                    }
                    
                }
                completion(.success(doctors))
                
            }

        }
        
        
        
    }
    
    
    
}
