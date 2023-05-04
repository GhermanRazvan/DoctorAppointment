//
//  AddClinicView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 04.05.2023.
//

import SwiftUI


struct AddClinicView: View {
    @State var clinicName: String = ""
    @State var clinicStreet: String = ""
    @State var clinicNumber: String = ""
    @State var clinicPostalCode: String = ""
    @State var clinicCountry: String = ""
    @State var clinicCity: String = ""
    var body: some View {
        VStack{
            TextField("Clinic name", text: $clinicName)
            Text("Address")
            TextField("Clinic street", text: $clinicStreet)
            TextField("Clinic number", text: $clinicNumber)
            TextField("Clinic postal code", text: $clinicPostalCode)
            TextField("Clinic country", text: $clinicCountry)
            TextField("Clinic city", text: $clinicCity)
            
        }
        
    }
}

struct AddClinicView_Previews: PreviewProvider {
    static var previews: some View {
        AddClinicView()
    }
}
