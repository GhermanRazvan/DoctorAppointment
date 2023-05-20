//
//  ConfirmAppointmentView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 20.05.2023.
//

import SwiftUI

struct ConfirmAppointmentView: View {
    @Environment (\.dismiss) var dismiss
    @AppStorage("email") var userEmail: String = ""
    var doctor: Doctor
    var date: Date
    var hour: String
    var body: some View {
        VStack{
            Button {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                let ymd = formatter.string(from: date)
                formatter.dateFormat = "yyyy/MM/dd H:mm"
                
                let selectedDate = formatter.date(from: "\(ymd) \(hour)")
                if selectedDate != nil{
                    let appointment = Appointment(doctorID: doctor.email, pacientID: userEmail, appointmentDate: selectedDate!)
                    AppointmentManager.shared.createAppointment(appointment: appointment)
                    dismiss()
                    
                }
                
            } label: {
                Text("Confirm")
            }
            
        }.onAppear{
            
        }
    }
}

struct ConfirmAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmAppointmentView(doctor: Doctor(firstName: "", middleName: "", lastName: "", phoneNumber: "", email: "", profession: "", about: "", clinicId: "", isActive: false, profilePicture: ""), date: Date(), hour: "")
    }
}
