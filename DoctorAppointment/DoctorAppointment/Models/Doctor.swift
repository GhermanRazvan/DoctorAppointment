//
//  Doctor.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 03.04.2023.
//

import Foundation

public struct Doctor: Codable {
    let firstName: String
    let middleName: String?
    let lastName: String
    let phoneNumber: String
    let email: String
    let profession: String
    let about: String?
    let clinicId: String
    
    enum CodingKeys: String, CodingKey{
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
        case email
        case profession
        case about
        case clinicId = "clinic_id"
    }
}


