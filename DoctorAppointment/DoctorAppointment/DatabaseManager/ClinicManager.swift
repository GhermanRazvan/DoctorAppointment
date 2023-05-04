//
//  ClinicaManager.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 02.05.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseCore


class ClinicManager {
    static let shared = ClinicManager()
    private let db = Firestore.firestore()
    private init () {}
    
    func getClinic(completion: @escaping ([Clinic]?) -> ()){
        var clinics: [Clinic] = []
        db.collection("Clinic").getDocuments { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
            }
            else {
                for document in snapshot!.documents{
                    
                    let result = Result{
                        try document.data(as: Clinic.self)
                        
                    }
                    switch result{
                    case .success(let item):
                        clinics.append(item)
                    case .failure(let err):
                        print("Couldn't parse clinics \(err.localizedDescription)")
                    }
                    
                }
                completion(clinics)
                
            }
            
        }
    }
    
    
}