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
    
    func getDoctorForEmail(email: String, completion: @escaping (Doctor?) -> () ){
        
        db.collection("Doctor").document(email).getDocument(as: Doctor.self) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                completion(nil)
                print("Error getting doctor \(failure)")
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
            try db.collection("Doctor").document(doctor.email).setData(from: doctor)
        } catch let error {
            print("Error writing doctor to Firestore: \(error)")
        }
        
    }
    
    func deleteDoctor(doctorID: String){
        db.collection("Doctor").document("\(doctorID)").delete() { err in
            if let err = err {
                print("Error removing doctor: \(err)")
            } else {
                print("Doctor successfully removed!")
            }
        }
    }
    
    func verifyDoctorAcccount(email: String, completion: @escaping (Bool?) -> ()) {
        
        db.collection("Doctor").whereField("email", isEqualTo: email).getDocuments { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
            }
            else {
                
                let result = Result{
                    try snapshot!.documents[0].data(as: Doctor.self)
                    
                }
                switch result{
                case .success(let item):
                    completion(item.isActive)
                case .failure(let err):
                    print("Couldn't parse doctor \(err.localizedDescription)")
                }
                
            }
        }
        
    }
    
    
    func confirmDoctorAccount(phoneNumber:String, about:String,  profession:String, email: String){
        
        db.collection("Doctor").document(email).updateData([
            "phone_number": phoneNumber,
            "profession": profession,
            "about": about,
            "is_active": true
            
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                
            } else
            {
                print("Document successfully updated")
                
            }
        }
    }
    
    func updatePersonalInfromation(firstName:String,   middleName:String, lastName:String, about:String, phoneNumber: String, email: String){
        
        db.collection("Doctor").document(email).updateData([
            "first_name": firstName,
            "middle_name": middleName,
            "last_name": lastName,
            "about": about,
            "phone_number": phoneNumber
            
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                
            } else
            {
                print("Document successfully updated")
                
            }
        }
    }
    
    func updateProfilePicture(profilePicture: String,  email: String){
        
        db.collection("Doctor").document(email).updateData([
            "profile_picture": profilePicture
            
        ]){ err in
            if let err = err {
                print("Error updating picture: \(err.localizedDescription)")
                
            } else
            {
                print("Picture successfully updated")
                
            }
        }
    }
    
    
    
}
