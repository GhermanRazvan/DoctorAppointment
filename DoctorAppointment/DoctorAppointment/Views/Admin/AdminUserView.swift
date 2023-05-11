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
            
            List{
                
                ForEach(doctors) {doctor in
                    
                    NavigationLink{
                        
                        AdminDoctorView(doctor: doctor)
                        
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
                    
                }.onDelete(perform: removeRows)
                
                
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
    
    func removeRows(at offsets: IndexSet) {
        let doctorID = doctors[offsets.first!].id!
        doctors.remove(atOffsets: offsets)

        DoctorManager.shared.deleteDoctor(doctorID: doctorID)
        
        //Todo: DELETE FROM Auth and UserRoles
        
    }

}
    


struct AdminUserView_Previews: PreviewProvider {
    static var previews: some View {
        AdminUserView()
    }
}
