//
//  ChatManager.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 25.05.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class ChatManager{
    
    static let shared = ChatManager()
    let db = Firestore.firestore()
    
    private init(){}
    
    func getChatsForPacient(email: String, completion: @escaping ([Chat]?) -> ()){
        var chats: [Chat] = []
        db.collection("Chat").whereField("pacient_id", isEqualTo: email).getDocuments { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
            }
            else {
                for document in snapshot!.documents{
                    
                    let result = Result{
                        try document.data(as: Chat.self)
                        
                    }
                    switch result{
                    case .success(let item):
                        chats.append(item)
                    case .failure(let err):
                        print("Error parsing chat \(err.localizedDescription)")
                    }
                    
                }
                completion(chats)
                
            }
            
        }
        
    }
    
    func getChatsForDoctor(email: String, completion: @escaping ([Chat]?) -> ()){
        var chats: [Chat] = []
        db.collection("Chat").whereField("doctor_id", isEqualTo: email).getDocuments { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
            }
            else {
                for document in snapshot!.documents{
                    
                    let result = Result{
                        try document.data(as: Chat.self)
                        
                    }
                    switch result{
                    case .success(let item):
                        chats.append(item)
                    case .failure(let err):
                        print("Error parsing chat \(err.localizedDescription)")
                    }
                    
                }
                completion(chats)
                
            }
            
        }
        
    }
    
    func checkIfChatExists(doctorID: String, pacientID: String, completion: @escaping (Bool?) -> ()){
        db.collection("Chat")
            .whereField("doctor_id", isEqualTo: doctorID)
            .whereField("pacient_id", isEqualTo: pacientID)
            .getDocuments { snapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(nil)
                }else{
                    if snapshot!.documents.isEmpty{
                        completion(false)
                    }else{
                        completion(true)
                    }
                }
                
            }
    }
    
    func createChat(chat: Chat){
        do {
            try db.collection("Chat").addDocument(from: chat)
        } catch let error {
            print("Error writing chat to Firestore: \(error)")
        }
        
    }
    
}
