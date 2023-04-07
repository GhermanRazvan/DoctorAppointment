//
//  UserRoleManager.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 07.04.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseCore

class UserRoleManager{
    static let shared = UserRoleManager()
    private let db = Firestore.firestore()
    private init () {}
    
    func addUserRole(email:String, role:String){
        
        db.collection("UserRole").document(email).setData(["email":email, "role":role]) { err in
            if let err = err {
                print(err.localizedDescription)
            }
        }
    }
    
    func getUserRoleForEmail(email:String, completion: @escaping (String?) -> ()  ){
        print(email)
        db.collection("UserRole").document(email).getDocument { snapshot, err in
            
            if let snapshot = snapshot, snapshot.exists{
                completion((snapshot.get("role") as? String))
            }else {
                print("Document does not exist")
                completion (nil)

            }
            
            
        }
        
    }
    
    
}
