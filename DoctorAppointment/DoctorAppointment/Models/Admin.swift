//
//  Admin.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 02.05.2023.
//

import Foundation


public struct Admin: Codable {
    let firstName: String
    let middleName: String?
    let lastName: String
    let phoneNumber: String
    let email: String
   
    
    enum CodingKeys: String, CodingKey{
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
        case email
        
    }
}
