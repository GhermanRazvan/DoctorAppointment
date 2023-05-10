//
//  AddClinicView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 04.05.2023.
//

import SwiftUI


struct AddClinicView: View {
    @Environment (\.dismiss) var dismiss
    @State var clinicName: String = ""
    @State var clinicStreet: String = ""
    @State var clinicNumber: String = ""
    @State var clinicPostalCode: String = ""
    @State var clinicCountry: String = ""
    @State var clinicCity: String = ""
    
    
    var body: some View {
        VStack{
            TextField("Clinic name", text: $clinicName)
                .disableAutocorrection(true)
            Text("Address")
            TextField("Clinic street", text: $clinicStreet)
                .disableAutocorrection(true)
            TextField("Clinic number", text: $clinicNumber)
                .disableAutocorrection(true)
            TextField("Clinic postal code", text: $clinicPostalCode)
                .disableAutocorrection(true)
            TextField("Clinic country", text: $clinicCountry)
                .disableAutocorrection(true)
            TextField("Clinic city", text: $clinicCity)
                .disableAutocorrection(true)
            Button("Add clinic") {
                let clinic = Clinic(name: clinicName, street: clinicStreet, number: clinicNumber, country: clinicCountry, zipCode: clinicPostalCode, city: clinicCity)
                ClinicManager.shared.addClinic(clinic: clinic)
                dismiss()
            }
        }
        
        
        
    }
}

struct AddClinicView_Previews: PreviewProvider {
    static var previews: some View {
        AddClinicView()
    }
}
