//
//  AdminUserView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 04.05.2023.
//

import SwiftUI

struct AdminUserView: View {
    @State var doctors: [Doctor] = []
    var body: some View {
        NavigationView{
            
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
            .navigationTitle("Doctors")
            .toolbar {
                NavigationLink{
                    
                        AddUserView()
                    }label: {
                    Image(systemName: "plus")
                }
            }
            
            
            
        }.onAppear{
            DoctorManager.shared.getAllDoctors { result in
                if let result = result {
                    doctors = result
                }
            }
        }
    }
}

struct AdminUserView_Previews: PreviewProvider {
    static var previews: some View {
        AdminUserView()
    }
}
