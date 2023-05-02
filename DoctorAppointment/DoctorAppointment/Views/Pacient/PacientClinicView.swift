//
//  PacientClinicPage.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 02.05.2023.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore
import CoreLocation
import Contacts


struct PacientClinicView: View {
    @State var clinics: [Clinic] = []
    var body: some View {
        NavigationView{
            
            List($clinics){ $clinic in
                
                VStack{
                    Text("\(clinic.name)")
                    Text("\(clinic.address)")
                        .onAppear {
                            let locationUtil = LocationUtil()
                            locationUtil.geoCodeLocation(lat: clinic.location.latitude, long: clinic.location.longitude){
                                location in
                                if let location  = location {
                                    
                                    clinic.address = "\(location.street)"
                                    
                                    
                                }
                            }
                        }
                   
                }
                
                
            }
            .navigationTitle("Home")
            
                
        }.onAppear{ClinicManager.shared.getClinic { result in
            if let result = result
            {
                clinics = result
            }
        }}
        
    }
    
    
}

struct PacientClinicView_Previews: PreviewProvider {
    static var previews: some View {
        PacientClinicView()
    }
}
