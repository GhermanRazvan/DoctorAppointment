//
//  DoctorSettingView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 14.05.2023.
//

import SwiftUI
import FirebaseAuth

struct DoctorSettingView: View {
    @Environment (\.dismiss) var dismiss
    @AppStorage("email") var userEmail: String = ""
    var body: some View {
        NavigationView{
            List{
                Section{
                    NavigationLink("Personal information"){
        
                        PersonalInfoSettingsView()
                        
                    }
                    NavigationLink("Change password"){
                        PasswordSettingsView()
                    }
                }header: {
                    Text("Account settings")
                }
                Section{
                    NavigationLink("Reviews"){
                        ReviewSettingsView()
                    }
                    
                }header: {
                    Text("Review settings")
                }
                Button(action: {
                    let firebaseAuth = Auth.auth()
                    do {
                        try firebaseAuth.signOut()
                            userEmail = ""
                            dismiss()
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)

                    }
                }){
                    Text("Sign out User")
                }
                
            }.navigationTitle("Settings")
        }
        
        
        
    }
}


struct DoctorSettingView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorSettingView()
    }
}
