//
//  AdminHomeView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 07.04.2023.
//

import SwiftUI

struct AdminHomeView: View {
    var body: some View {
        TabView{
            AdminClinicView()
                .tabItem{
                    Image(systemName: "building")
                    Text("Clinics")
                }
            AdminUserView()
                .tabItem{
                    Image(systemName: "person.crop.circle")
                    Text("Accounts")
                }
            AdminSettingsView()
                .tabItem{
                    Image(systemName: "person")
                    Text("User")
                }
        }
    }
}

struct AdminHomeView_Previews: PreviewProvider {
    static var previews: some View {
        AdminHomeView()
    }
}
