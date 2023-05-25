//
//  Message.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 25.05.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct Message: Codable, Identifiable {
    @DocumentID public var id: String? = UUID().uuidString
    let fromUserID: String
    let toUserID: String
    let date: Date
    let messageText: String
    
    
 
    
   
    
    enum CodingKeys: String, CodingKey{
        case id = "documentID"
        case fromUserID = "from_user_id"
        case toUserID = "to_user_id"
        case date
        case messageText = "message_text"
        
        
    }
}
