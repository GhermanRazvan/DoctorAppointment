//
//  PasswordSettingsView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 14.05.2023.
//

import SwiftUI
import FirebaseAuth

struct PasswordSettingsView: View {
    @Environment (\.dismiss) var dismiss
    @State var newPassword: String = ""
    @State var confirmPassword: String = ""
    @State var isValid: Bool = true
    var body: some View {
        VStack{
            
            TextField("New password", text: $newPassword)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            TextField("Confirm password", text: $confirmPassword)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            
            if !isValid {
                Text("Passwords do not match")
            }
            
            Button("Update password") {
                if newPassword == confirmPassword {
                    Auth.auth().currentUser?.updatePassword(to: newPassword){ err in
                        if err == nil {
                            dismiss()
                        }
                    }
                }else {
                    isValid = false
                }
            }
        }
    }
}

struct PasswordSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordSettingsView()
    }
}
