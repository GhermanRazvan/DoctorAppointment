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
    
    func getAllDoctors(completion: @escaping ([Doctor]?) -> () ){
        var doctors: [Doctor] = []
        db.collection("Doctor").getDocuments { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
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
                        print("Error parsing doctor \(err.localizedDescription)")
                    }
                    
                }
                completion(doctors)
                
            }

        }
        
        
        
    }
    
    func getDoctorsForClinic(clinicID: String, completion: @escaping ([Doctor]?) -> ()){
        var doctors: [Doctor] = []
        db.collection("Doctor").whereField("clinic_id", isEqualTo: clinicID).getDocuments { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
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
                        print("Couldn't parse doctor \(err.localizedDescription)")
                    }
                    
                }
                completion(doctors)
                
            }
            
        }
    }
    
    
    func addDoctor(doctor: Doctor){
        
        do {
            try db.collection("Doctor").addDocument(from: doctor)
        } catch let error {
            print("Error writing doctor to Firestore: \(error)")
        }
        
    }
    
    
    
}
