//
//  DoctorActivationView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 11.05.2023.
//

import SwiftUI
import FirebaseAuth

struct DoctorActivationView: View {
    @Environment (\.dismiss) var dismiss
    @AppStorage("email") var userEmail: String = ""
    @State var phoneNumber: String = ""
    @State var about: String = ""
    @State var profession: String = ""
    @State var changePassword: String = ""
    
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Phone number", text: $phoneNumber)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                TextField("About", text: $about)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                TextField("Profession", text: $profession)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                TextField("Reset Password", text: $changePassword)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                Button("Activate account") {
                    DoctorManager.shared.confirmDoctorAccount(phoneNumber: phoneNumber, about: about, profession: profession, email: userEmail)
                    
                    Auth.auth().currentUser?.updatePassword(to: changePassword) { error in
                        
                    }
                    dismiss()
                }
                
            }.navigationTitle("Activate account")
            
        }
    }
    
}

struct DoctorActivationView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorActivationView()
    }
}
