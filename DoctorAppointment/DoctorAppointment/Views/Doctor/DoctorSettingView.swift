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
    @State var isEnabled: Bool = true
    var body: some View {
        NavigationView{
            List{
                Section{
                    Toggle("Enable account", isOn: $isEnabled)
                        .onChange(of: isEnabled) { newValue in
                            DoctorManager.shared.changeAccountStatus(email: userEmail, state: newValue)
                        }
                }header: {
                    Text("Enable account")
                }
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
                
            }
            .navigationTitle("Settings")
            .onAppear{
                DoctorManager.shared.getDoctorForEmail(email: userEmail) { rez in
                    if let rez = rez{
                        isEnabled = rez.isEnabled
                    }
                }
            }
        }
        
        
        
    }
}


struct DoctorSettingView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorSettingView()
    }
}
