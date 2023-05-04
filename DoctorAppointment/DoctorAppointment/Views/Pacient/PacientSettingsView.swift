//
//  PacientSettingsView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 02.05.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestoreSwift

struct PacientSettingsView: View {
    @AppStorage("uid") var userID: String = ""
    @AppStorage("email") var userEmail: String = ""
    var body: some View {
                Button(action: {
                    let firebaseAuth = Auth.auth()
                    do {
                        try firebaseAuth.signOut()
                        withAnimation{
                            userID =  ""
                            userEmail = ""
                        }
        
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
        
                    }
                }){
                    Text("Sign out User")
                }
    }
}

struct PacientSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PacientSettingsView()
    }
}
