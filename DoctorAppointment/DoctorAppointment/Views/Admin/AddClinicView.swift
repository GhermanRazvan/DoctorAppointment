//
//  AddClinicView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 04.05.2023.
//

import SwiftUI
import PhotosUI
import UIKit

struct AddClinicView: View {
    @Environment (\.dismiss) var dismiss
    @State var clinicName: String = ""
    @State var clinicStreet: String = ""
    @State var clinicNumber: String = ""
    @State var clinicPostalCode: String = ""
    @State var clinicCountry: String = ""
    @State var clinicCity: String = ""
    @State var imageURL: String = ""
    @State var selectedItem: PhotosPickerItem? = nil
    @State var selectedImageData: Data? = nil
    @State var image: UIImage? = nil
    @State var clinicID: String = ""
    
    var body: some View {
        VStack{
            if image != nil{
                Image(uiImage: image!)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 2))
               
            }else {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 2))
                
            }
            
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Text("Update picture")
            }.onChange(of: selectedItem) { newItem in
                Task{

                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                        if let selectedImageData {
                             image = UIImage(data: selectedImageData)

                        }
                    }
                }
            }
            Group{
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
            }
            Button("Add clinic") {
                let group = DispatchGroup()
                let queue = DispatchQueue(label: "Save clinic picture")
                group.enter()
                queue.async {
                    let clinic = Clinic(name: clinicName, street: clinicStreet, number: clinicNumber, country: clinicCountry, zipCode: clinicPostalCode, city: clinicCity, clinicImage: "")
                    ClinicManager.shared.addClinic(clinic: clinic){ result in
                         
                        if let result = result {
                            
                            clinicID = result
                            
                        }
                        group.leave()
                        
                    }
                }
                queue.async {
                    group.wait()
                    group.enter()
                    let path = "pictures/clinic/" + clinicID + "/clinicPicture.png"
                    StorageManager.shared.addImageToFirebaseStorage(image: image!, toPath: path) { rez in
                        print(rez)
                        group.leave()
                    }
                }
                queue.async {
                    group.wait()
                    group.enter()
                    StorageManager.shared.getClinicPictureURL(clinicID: clinicID){ rez in
                        switch rez {
                        case .success(let success):
                            imageURL = success.absoluteString
                            print(imageURL)
                        case .failure(let failure):
                            print(failure)
                        }
                        group.leave()
                    }
                }
                queue.async {
                    group.wait()
                    group.enter()
                    ClinicManager.shared.updateClinicPicture(clinicPicture: imageURL, clinicID: clinicID)
                    DispatchQueue.main.async {
                        dismiss()
                    }
                    group.leave()
                }
            }
            Spacer()
        }

    }
}

struct AddClinicView_Previews: PreviewProvider {
    static var previews: some View {
        AddClinicView()
    }
}
