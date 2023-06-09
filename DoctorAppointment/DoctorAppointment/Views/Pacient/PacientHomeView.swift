//
//  PacientHomeView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 07.04.2023.
//

import SwiftUI
import FirebaseAuth

struct PacientHomeView: View {
   
    @AppStorage("email") var userEmail: String = ""
    var body: some View {
        
        TabView{
            PacientClinicView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            PacientAppointmentView()
                .tabItem{
                    Image(systemName: "calendar.badge.clock")
                    Text("Appointments")
                }
            ChatView()
                .tabItem{
                    Image(systemName: "message")
                    Text("Chat")
                }
            PacientSettingsView()
                .tabItem{
                    Image(systemName: "person")
                    Text("User")
                }
        }
    }
}

struct PacientHomeView_Previews: PreviewProvider {
    static var previews: some View {
        PacientHomeView()
    }
}
