//
//  CalendarView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 20.05.2023.
//

import SwiftUI

struct CalendarView: View {
    var doctor: Doctor
    @State private var date: Date = Date()
    @State private var appointments: [Appointment] = []
    @State private var hours: [String] = ["9:00", "9:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00"]
    @State private var avaliableHours: [String] = ["9:00", "9:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00"]
    @State var startingDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    func selectDate(date:Date, from appointments: [Appointment]) -> [String]{
        var result: [Appointment] = []
        var hoursCopy = hours
        let dateFormatter = DateFormatter()
        //        dateFormatter.timeZone = TimeZone(secondsFromGMT: 7200)
        dateFormatter.dateFormat = "EEEE"
        
        let selectedDay = dateFormatter.string(from: date)
        
        for appointment in appointments {
            if appointment.doctorID == doctor.email{
                let day = dateFormatter.string(from: appointment.appointmentDate)
                if selectedDay == day {
                    result.append(appointment)
                }
            }
            
            
        }
        
        for appointment in result {
            let dateFormatter = DateFormatter()
            //            dateFormatter.timeZone = TimeZone(secondsFromGMT: 7200)
            dateFormatter.dateFormat = "H:mm"
            let h = dateFormatter.string(from: appointment.appointmentDate)
            print(h)
            if hoursCopy.contains(h){
                let key = hoursCopy.firstIndex(of: h)
                if key != nil {
                    hoursCopy.remove(at: key!)
                }
                
            }
            
        }
        return hoursCopy
    }
    
    
    
    var body: some View {
        VStack{
            
            DatePicker("Pick a date", selection: $date, in: startingDate... ,displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .onChange(of: date) { newValue in
                    avaliableHours = selectDate(date: newValue, from: appointments)
                    
                    
                }
            List{
                ForEach(avaliableHours, id: \.self) { hour in

                    NavigationLink {
                        ConfirmAppointmentView(doctor: doctor, date: date, hour: hour)
                        
                        
                    } label: {
                        Text(hour)
                    }
                    
                }
            }
            Spacer()
            
        }.onAppear{
            AppointmentManager.shared.getAllAppointments { rez in
                if let rez = rez {
                    appointments = rez
                    avaliableHours = selectDate(date: date, from: appointments)
                }
            }
        }
        
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(doctor: Doctor(firstName: "", middleName: "", lastName: "", phoneNumber: "", email: "", profession: "", about: "", clinicId: "", isActive: false, profilePicture: "", isEnabled: true))
    }
}
