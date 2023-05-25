//
//  Chat.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 25.05.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


public struct Chat: Codable, Identifiable {
    @DocumentID public var id: String? = UUID().uuidString
    let doctorID: String
    let pacientID: String
    
    
    enum CodingKeys: String, CodingKey{
        case id = "documentID"
        case doctorID = "doctor_id"
        case pacientID = "pacient_id"
    }
}
