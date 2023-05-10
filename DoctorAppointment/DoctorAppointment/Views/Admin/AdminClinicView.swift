//
//  AdminClinicView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 04.05.2023.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore

struct AdminClinicView: View {
    @State var clinics: [Clinic] = []
  
    var body: some View {
        NavigationView{
            
            List{
                
                ForEach(clinics){ clinic in
                   
                        
                        
                        VStack(alignment: .leading){
                            Text("\(clinic.name)")
                            
                            HStack{
                                Text("\(clinic.street)")
                                Text("\(clinic.number)")
                                //Text("\(clinic.city) ")
                                //Text("\(clinic.country) ")
                                //Text("\(clinic.zipCode)")
                            }
                            
                            
                        }
                    
                    
                }
                .onDelete(perform: removeRows)
            }

            .navigationTitle("Clinics")
            .toolbar {
                NavigationLink{
                    
                        AddClinicView()
                    }label: {
                    Image(systemName: "plus")
                }
            }
            
            
            
        }
       
        .onAppear{
            ClinicManager.shared.getClinic { result in
            if let result = result
            {
                clinics = result
            }
        }
        
        }
    }
    func removeRows(at offsets: IndexSet) {
        let clinicID = clinics[offsets.first!].id!
        clinics.remove(atOffsets: offsets)

        ClinicManager.shared.deleteClinics(clinicID: clinicID)
        
    }

}

struct AdminClinicView_Previews: PreviewProvider {
    static var previews: some View {
        AdminClinicView()
    }
}
