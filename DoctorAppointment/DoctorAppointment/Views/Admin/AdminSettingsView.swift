//
//  AdminSettingsView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 04.05.2023.
//

import SwiftUI
import FirebaseAuth
struct AdminSettingsView: View {
    @Environment (\.dismiss) var dismiss

    @AppStorage("email") var userEmail: String = ""
    var body: some View {
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
}

struct AdminSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AdminSettingsView()
    }
}
