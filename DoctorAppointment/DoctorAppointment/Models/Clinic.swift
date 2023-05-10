//
//  Clinica.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 02.05.2023.
//

import Foundation
import CoreLocation
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct Clinic: Codable, Identifiable {
    @DocumentID public var id: String? = UUID().uuidString
    let name: String
    var street: String
    var number: String
    var country: String
    var zipCode: String
    var city: String
    
    
    
    
    enum CodingKeys: String, CodingKey{
        case id = "documentID"
        case name
        case street
        case number
        case country
        case zipCode = "zip_code"
        case city
        
        
    }
}
