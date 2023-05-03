//
//  Reviews.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 03.05.2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

public struct Review: Codable, Identifiable {
    @DocumentID public var id: String? = UUID().uuidString
    let reviewScore: Int
    let text: String
    let doctorID: String
    let pacientID: String
    
    
    
    
    enum CodingKeys: String, CodingKey{
        case id = "documentID"
        case reviewScore = "review_score"
        case text = "text"
        case doctorID = "doctor_id"
        case pacientID = "pacient_id"
        
    }
}
