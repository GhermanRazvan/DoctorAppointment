//
//  Doctor.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 03.04.2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

public struct Doctor: Codable, Identifiable {
    @DocumentID public var id: String? = UUID().uuidString
    let firstName: String
    let middleName: String?
    let lastName: String
    let phoneNumber: String
    let email: String
    let profession: String
    let about: String?
    let clinicId: String
    let isActive: Bool
    let profilePicture: String?
    let isEnabled: Bool
    
    
    enum CodingKeys: String, CodingKey{
        case id = "documentID"
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
        case email
        case profession
        case about
        case clinicId = "clinic_id"
        case isActive = "is_active"
        case profilePicture = "profile_picture"
        case isEnabled = "is_enabled"
        
    }
}


