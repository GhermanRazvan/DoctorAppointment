//
//  AppointmentManager.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 20.05.2023.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class AppointmentManager{
    static let shared = AppointmentManager()
    let db = Firestore.firestore()
    
    private init(){}
    
    func getAllAppointments(completion: @escaping ([Appointment]?) -> ()){
        var appointments: [Appointment] = []
        db.collection("Appointment").getDocuments { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
            }
            else {
                for document in snapshot!.documents{
                    
                    let result = Result{
                        try document.data(as: Appointment.self)
                        
                    }
                    switch result{
                    case .success(let item):
                        appointments.append(item)
                    case .failure(let err):
                        print("Error parsing appointment \(err.localizedDescription)")
                    }
                    
                }
                completion(appointments)
                
            }
            
        }
    }
    
    func createAppointment(appointment: Appointment){
        
        do {
            try db.collection("Appointment").addDocument(from: appointment)
        } catch let error {
            print("Error writing doctor to Firestore: \(error)")
        }
        
    }
    
    func getAppointmentsForPacient(email: String, completion: @escaping ([Appointment]?) -> ()){
        var appointments: [Appointment] = []
        db.collection("Appointment").whereField("pacient_id", isEqualTo: email).getDocuments { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
            }
            else {
                for document in snapshot!.documents{
                    
                    let result = Result{
                        try document.data(as: Appointment.self)
                        
                    }
                    switch result{
                    case .success(let item):
                        appointments.append(item)
                    case .failure(let err):
                        print("Error parsing appointment \(err.localizedDescription)")
                    }
                    
                }
                completion(appointments)
                
            }
            
        }
    }
    
    func getAppointmentsForDoctor(email: String, completion: @escaping ([Appointment]?) -> ()){
        var appointments: [Appointment] = []
        db.collection("Appointment").whereField("doctor_id", isEqualTo: email).getDocuments { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
            }
            else {
                for document in snapshot!.documents{
                    
                    let result = Result{
                        try document.data(as: Appointment.self)
                        
                    }
                    switch result{
                    case .success(let item):
                        appointments.append(item)
                    case .failure(let err):
                        print("Error parsing appointment \(err.localizedDescription)")
                    }
                    
                }
                completion(appointments)
                
            }
            
        }
    }
   
}
