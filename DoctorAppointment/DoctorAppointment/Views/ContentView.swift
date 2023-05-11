//
//  ContentView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 03.04.2023.
//

import SwiftUI
import FirebaseAuth


struct ContentView: View {
    
    @AppStorage("uid") var userID: String = ""
    @AppStorage("email") var userEmail: String = ""
    @State var roleApp: String = ""
    
    var body: some View {
        
        if userID == "" {
            AuthView()
        }else {
            NavigationStack{
                if roleApp == "pacient"{
                    PacientHomeView()
                }else if roleApp == "doctor" {
                    DoctorHomeView()
                }else if roleApp == "admin"{
                    AdminHomeView()
                }
            }.onAppear{UserRoleManager.shared.getUserRoleForEmail(email: userEmail) { role in
                if let role = role{
                    roleApp = role
                }
            }}
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
