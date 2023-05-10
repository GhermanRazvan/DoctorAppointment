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
            
            
                
                List(clinics){ clinic in
                    NavigationLink{
                        DoctorListView(clinic: clinic)
                    }label:{
                        
                        
                        VStack(alignment: .leading){
                            Text("\(clinic.name)")
                            HStack{
                                Text("\(clinic.street)")
                                Text("\(clinic.number)")
                                Text("\(clinic.city)")
                                Text("\(clinic.country)")
                                Text("\(clinic.zipCode)")
                            }
                            
                            
                        }
                    }
                    
                    
                }
            
            .navigationTitle("Home")
           
        }
        
        .onAppear{
            ClinicManager.shared.getClinic { result in
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
