//
//  DoctorAppointmentView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 23.05.2023.
//

import SwiftUI

struct DoctorAppointmentView: View {
    @AppStorage("email") var userEmail: String = ""
    @State var appointments: [Appointment] = []
    var body: some View {
        NavigationStack{
            List{
                Section{
                    ForEach(appointments){ appointment in
                        
                        if appointment.appointmentDate >= Date(){
                            VStack{
                                if appointment.pacientName != nil{
                                    Text("\(appointment.pacientName!)")
                                }
                                
                                Text("\(appointment.appointmentDate)")
                                
                            }
                            
                        }
                        
                    }
                    
                }header:{
                    Text("Upcoming")
                }
                Section{
                    ForEach(appointments){ appointment in
                        
                        if appointment.appointmentDate < Date(){
                            VStack{
                                if appointment.pacientName != nil{
                                    Text("\(appointment.pacientName!)")
                                }
                                Text("\(appointment.appointmentDate)")
                                
                            }
                            
                        }
                        
                    }
                    
                    
                }header: {
                    Text("Completed")
                }
                
            }.navigationTitle("Appointments")
        }.onAppear{
            let group = DispatchGroup()
            let queue = DispatchQueue(label: "Appointment queue")
            group.enter()
            queue.async {
                AppointmentManager.shared.getAppointmentsForDoctor(email: userEmail) { rez in
                    if let rez = rez {
                        appointments = rez
                    }
                    group.leave()
                }
            }
            queue.async {
                group.wait()
                for i in appointments.indices {
                    group.enter()
                    PacientManager.shared.getPacientForEmail(email: appointments[i].pacientID) { rez in
                        if let rez = rez {
                            let name = "\(rez.firstName) \(rez.middleName ?? "") \(rez.lastName)"
                            appointments[i].pacientName = name
                            
                        }
                        group.leave()
                    }
                }
                
            }
            
            
        }
    }
}

struct DoctorAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorAppointmentView()
    }
}
