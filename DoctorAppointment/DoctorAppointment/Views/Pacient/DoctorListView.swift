//
//  DoctorView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 03.05.2023.
//

import SwiftUI

struct DoctorListView: View {
    var clinic: Clinic
    @State var doctors: [Doctor] = []
    var body: some View {
       
        NavigationStack{
            
           
            
          
                
                Image("rosie")
                    .resizable()
                    .scaledToFill()
                    .frame( height: 100)
                
//                VStack(alignment: .leading){
//
//                    Text("\(clinic.street)")
//                    Text("\(clinic.number)")
//                    Text("\(clinic.city)")
//                    Text("\(clinic.country)")
//                    Text("\(clinic.zipCode)")
//
//                }
//
                
                
            
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
            
            DoctorManager.shared.getDoctorsForClinic(clinicID: clinic.id!) { result in
                if let result = result {
                    
                    doctors = result
                    
                }
                    
            }
        }
    }
}

struct DoctorListView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorListView(clinic: Clinic(name: "", street: "", number: "", country: "", zipCode: "", city: ""))
    }
}
