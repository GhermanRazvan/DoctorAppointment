//
//  DoctorHomeView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 07.04.2023.
//

import SwiftUI

struct DoctorHomeView: View {
    @AppStorage("email") var userEmail: String = ""
    @State var isActive: Bool = false
    var body: some View {
        
        
        TabView{
            DoctorAppointmentView()
                .tabItem{
                    Image(systemName: "calendar.badge.clock")
                    Text("Appointments")
                }
            DoctorChatView()
                .tabItem{
                    Image(systemName: "message")
                    Text("Chat")
                }
            DoctorSettingView()
                .tabItem{
                    Image(systemName: "person")
                    Text("User")
                }
        }
        .fullScreenCover(isPresented: $isActive, content: DoctorActivationView.init)
        
        
        
        
        .onAppear{
            
            DoctorManager.shared.verifyDoctorAcccount(email: userEmail) { rez in
                if let rez = rez {
                    isActive = !rez
                }
            }
            
        }
        
    }
    
}

struct DoctorHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorHomeView()
    }
}
