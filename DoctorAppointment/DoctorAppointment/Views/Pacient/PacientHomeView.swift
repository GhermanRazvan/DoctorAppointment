//
//  PacientHomeView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 07.04.2023.
//

import SwiftUI
import FirebaseAuth

struct PacientHomeView: View {
    @AppStorage("uid") var userID: String = ""
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
            PacientSettingsView()
                .tabItem{
                    Image(systemName: "person")
                    Text("User")
                }
        }
        
//        Button(action: {
//            let firebaseAuth = Auth.auth()
//            do {
//                try firebaseAuth.signOut()
//                withAnimation{
//                    userID =  ""
//                    userEmail = ""
//                }
//
//            } catch let signOutError as NSError {
//                print("Error signing out: %@", signOutError)
//
//            }
//        }){
//            Text("Sign out User")
//        }
    }
}

struct PacientHomeView_Previews: PreviewProvider {
    static var previews: some View {
        PacientHomeView()
    }
}
