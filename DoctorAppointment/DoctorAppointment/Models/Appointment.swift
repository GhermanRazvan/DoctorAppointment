//
//  Appointment.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 20.05.2023.
//

import Foundation
import CoreLocation
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct Appointment: Codable {
    @DocumentID public var id: String? = UUID().uuidString
    let doctorID: String
    let pacientID: String
    let appointmentDate: Date
    
 
    
   
    
    enum CodingKeys: String, CodingKey{
        case id = "documentID"
        case doctorID = "doctor_id"
        case pacientID = "pacient_id"
        case appointmentDate = "appointment_date"
        
        
    }
}
