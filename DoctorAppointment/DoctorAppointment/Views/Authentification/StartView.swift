//
//  StartView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 16.05.2023.
//

import SwiftUI

struct StartView: View {
    @AppStorage("email") var userEmail: String = ""
    @State var roleApp: String = "" 
    var body: some View {
        Group{
            if roleApp == "pacient"{
                PacientHomeView()
            }else if roleApp == "doctor" {
                DoctorHomeView()
            }else if roleApp == "admin"{
                AdminHomeView()
            }
        }.onAppear{
            
            UserRoleManager.shared.getUserRoleForEmail(email: userEmail) { role in
                if let role = role{
                    roleApp = role
                }
            }
            
        }
        
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
