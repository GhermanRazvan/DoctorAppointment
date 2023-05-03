//
//  DoctorView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 03.05.2023.
//

import SwiftUI

struct DoctorListView: View {
    var clinicID: String
    @State var doctors: [Doctor] = []
    var body: some View {
       
        NavigationStack{
            
        
            
            
            List(doctors) {doctor in
                
                NavigationLink{
                    
                    DoctorView(doctor: doctor)
                    
                }label:{
                    VStack(alignment: .leading){
                        HStack{
                            Text("\(doctor.firstName)")
                            if doctor.middleName != nil{
                                
                                Text("\(doctor.middleName!)")
                                
                            }
                            
                            Text("\(doctor.lastName)")
                        }
                        
                        Text("\(doctor.profession)")
                        
                    }
                    
                }
                
            }
        }.onAppear{
            
            DoctorManager.shared.getDoctorsForClinic(clinicID: clinicID) { result in
                if let result = result {
                    
                    doctors = result
                    
                }
                    
            }
        }
    }
}

struct DoctorListView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorListView(clinicID: "1")
    }
}
