//
//  AdminClinicView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 04.05.2023.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore

struct AdminClinicView: View {
    @State var clinics: [Clinic] = []
  
    var body: some View {
        NavigationView{
            
            List($clinics){ $clinic in
                NavigationLink{
                    
                    DoctorListView(clinicID: clinic.id!)
                }label:{
                    
                
                    VStack(alignment: .leading){
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
                
                
            }.navigationTitle("Clinics")
                .toolbar {
                    NavigationLink{
                        
                            AddClinicView()
                        }label: {
                        Image(systemName: "plus")
                    }
                }
            
            
            
        }
       
        .onAppear{
            ClinicManager.shared.getClinic { result in
            if let result = result
            {
                clinics = result
            }
        }
        
        }
    }
    
}

struct AdminClinicView_Previews: PreviewProvider {
    static var previews: some View {
        AdminClinicView()
    }
}
