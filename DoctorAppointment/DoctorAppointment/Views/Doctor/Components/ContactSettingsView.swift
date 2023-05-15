//
//  ContactSettingsView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 14.05.2023.
//

import SwiftUI

struct ContactSettingsView: View {
    var body: some View {
        @AppStorage("email") var userEmail: String = ""
        @State var email: String = ""
        @State var phoneNumber: String = ""
        @State var isEditing: Bool = false
        VStack{
            
            
            if isEditing{
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                TextField("Phone number", text: $phoneNumber)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
            }else {
                Text( email)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text( phoneNumber)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
        }
        
        if isEditing{
            Button("Update info") {
                DoctorManager.shared.updatePersonalInfromation(firstName: firstName, middleName: middleName, lastName: lastName, about: about, email: userEmail)
                
            }
            
            
        }
        
        
        Spacer()
        
        
            .toolbar{
                Button {
                    isEditing.toggle()
                } label: {
                    if isEditing{
                        Text("Cancel")
                    }else{
                        Text("Edit")
                    }
                }
                
            }
            .onAppear{
                DoctorManager.shared.getDoctorForEmail(email: userEmail) { result in
                    if let result = result {
                        phoneNumber = result.phoneNumber
                        
                        
                    }
                }
            }
        
    }
}

struct ContactSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactSettingsView()
    }
}
