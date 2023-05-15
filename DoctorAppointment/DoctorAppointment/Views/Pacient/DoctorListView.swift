//
//  DoctorView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 03.05.2023.
//

import SwiftUI

struct DoctorListView: View {
    var clinic: Clinic
    @State var doctors: [Doctor] = []
    var body: some View {
       
        NavigationStack{
            if clinic.clinicImage != nil {
                AsyncImage(url: URL(string: clinic.clinicImage!)){ phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                        .resizable()
                        .frame( height: 100)
                        .scaledToFill()
                        .aspectRatio(contentMode: .fill)
                    case .failure( _):
                        Image(systemName: "Photo")
                    @unknown default:
                        EmptyView()
                    }
                }
            }else {
                Image(systemName: "building.2")
                    .resizable()
                    .scaledToFill()
                    .frame( height: 100)
            }
            
               
                List(doctors) {doctor in
                    
                    NavigationLink{
                        
                        DoctorView(doctor: doctor)
                        
                    }label:{
                        VStack(alignment: .leading){
                            HStack{
                                Text("\(doctor.firstName)")
                                if doctor.middleName != nil{
                                    
                                    Text("\(doctor.middleName!)")
                                    
                                }
                                
                                Text("\(doctor.lastName)")
                            }
                            
                            Text("\(doctor.profession)")
                            
                        }
                        
                    }
                    
                }
            
        }.onAppear{
            
            DoctorManager.shared.getDoctorsForClinic(clinicID: clinic.id!) { result in
                if let result = result {
                    
                    doctors = result
                    
                }
                    
            }
        }
    }
}

struct DoctorListView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorListView(clinic: Clinic(name: "", street: "", number: "", country: "", zipCode: "", city: "", clinicImage: ""))
    }
}
