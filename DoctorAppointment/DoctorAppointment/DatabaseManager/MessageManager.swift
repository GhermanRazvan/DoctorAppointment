//
//  MessageManager.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 25.05.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class MessageManager{
    
    static let shared = MessageManager()
    let db = Firestore.firestore()
    
    private init(){}
    
    
    func getAllMessagedForUser(user1:String, user2:String, completion: @escaping ([Message]?) -> ()){
        var messages: [Message] = []
        db.collection("Message").whereFilter(Filter.orFilter([
            Filter.andFilter([
                Filter.whereField("from_user_id", isEqualTo: user1),
                Filter.whereField("to_user_id", isEqualTo: user2)]),
            Filter.andFilter([
                Filter.whereField("from_user_id", isEqualTo: user2),
                Filter.whereField("to_user_id", isEqualTo: user1)])])).getDocuments { snapshot, err in
                    if let err = err {
                        print("Error getting documents: \(err)")
                        completion(nil)
                    }
                    else {
                        for document in snapshot!.documents{
                            
                            let result = Result{
                                try document.data(as: Message.self)
                                
                            }
                            switch result{
                            case .success(let item):
                                messages.append(item)
                            case .failure(let err):
                                print("Error parsing message \(err.localizedDescription)")
                            }
                            
                        }
                        completion(messages)
                        
                    }
                    
                }
    }
    
    
    func addMessage(message: Message){
        do {
            try db.collection("Message").addDocument(from: message)
        } catch let error {
            print("Error writing message to Firestore: \(error)")
        }
        
    }
}
