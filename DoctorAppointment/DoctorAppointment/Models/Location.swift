//
//  Location.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 02.05.2023.
//

import Foundation
import CoreLocation
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct Location {
    var street: String
    var postalCode: String
    var country: String
    var city: String    
}
