//
//  AddUserView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 10.05.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AddUserView: View {
    @Environment (\.dismiss) var dismiss
    @State var firstName: String = ""
    @State var middleName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var clinics: [Clinic] = []
    @State var selectedClinic: String = "Select clinic"
    @State var stringClinics: [String] = []


    var body: some View {
        NavigationView{
            VStack{
                TextField("First name", text: $firstName)
                    .disableAutocorrection(true)
                TextField("Middle name", text: $middleName)
                    .disableAutocorrection(true)
                TextField("Last name", text: $lastName)
                    .disableAutocorrection(true)
                TextField("email", text: $email)
                    .disableAutocorrection(true)
                
                Form {
                    Picker("Clinics", selection: $selectedClinic) {
                        ForEach(stringClinics, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                Button("Add doctor") {
                    Auth.auth().createUser(withEmail: email, password: "password") { authResult, error in
                        
                    }
                    
                    var doctor = Doctor(firstName: firstName, middleName: middleName, lastName: lastName, phoneNumber: "", email: email, profession: "", about: "", clinicId: getClinicIdForClinicName(name: selectedClinic) )
                    DoctorManager.shared.addDoctor(doctor: doctor)
                    UserRoleManager.shared.addUserRole(email: email, role: "doctor")
                    dismiss()
                }
            }
            
        }
        .onAppear{
            ClinicManager.shared.getClinic { result in
                if let result = result {
                    clinics.removeAll()
                    stringClinics.removeAll()
                    for clinic in result{
                        stringClinics.append(clinic.name)
                    }
                    clinics = result
                }
            }
        }
       
    }
    
    func getClinicIdForClinicName(name: String) -> String{
        
        for clinic in clinics {
            if clinic.name == name {
                return clinic.id!
            }
        }
        return ""
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
    }
}
