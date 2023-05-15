//
//  PersonalInfoSettingsView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 14.05.2023.
//

import SwiftUI
import PhotosUI
import UIKit

struct PersonalInfoSettingsView: View {
    @AppStorage("email") var userEmail: String = ""
    @State var firstName: String = ""
    @State var middleName: String = ""
    @State var lastName: String = ""
    @State var about: String = ""
    @State var isEditing: Bool = false
    @State var phoneNumber: String = ""
    @State var selectedItem: PhotosPickerItem? = nil
    @State var selectedImageData: Data? = nil
    @State var imageURL = ""
    
    var body: some View {
        
        VStack{
            if imageURL != ""{
                AsyncImage(url: URL(string: imageURL)){ phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    case .failure( _):
                        Image(systemName: "Photo")
                    @unknown default:
                        EmptyView()
                    }
                }
            }else {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                
            }

               
            
            
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Text("Update picture")
            }.onChange(of: selectedItem) { newItem in
               
                Task{
                    
                    
                    let group = DispatchGroup()
                    let queue = DispatchQueue(label: "Save profile picture")
                    
                    
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                        if let selectedImageData {
                            print("TEST")
                            let uiImage = UIImage(data: selectedImageData)
                            let path = "pictures/doctor/" + userEmail + "/profilePicture.png"
                            group.enter()
                            queue.async {
                                
                                StorageManager.shared.addImageToFirebaseStorage(image: uiImage!, toPath: path) { result in
                                    print(result)
                                    group.leave()
                                }
                            }
                            queue.async {
                                group.wait()
                                group.enter()
                                StorageManager.shared.getItemPictureURL(email: userEmail) { rez in
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
                                DoctorManager.shared.updateProfilePicture(profilePicture: imageURL, email: userEmail)
                                group.leave()
                            }
                            
                            
                        }
                        
                    }
                }
                
                
                
            }
            VStack{
                
                
                if isEditing{
                    TextField("First name", text: $firstName)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    TextField("Middle name", text: $middleName)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    TextField("Last name", text: $lastName)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    TextField("About", text: $about)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    TextField("Phone number", text: $phoneNumber)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    Text(userEmail)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }else {
                    Text( firstName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text( middleName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text( lastName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text( about)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text( phoneNumber)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text( userEmail)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }
            
            if isEditing{
                Button("Update info") {
                    DoctorManager.shared.updatePersonalInfromation(firstName: firstName, middleName: middleName, lastName: lastName, about: about, phoneNumber: phoneNumber ,email: userEmail)
                    isEditing = false
                    
                }
            }
            
            
            Spacer()
            
        }
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
                    firstName = result.firstName
                    if let mN = result.middleName{
                        middleName = mN
                    }
                    
                    lastName = result.lastName
                    if let ab = result.about
                    {
                        about = ab
                    }
                    phoneNumber = result.phoneNumber
                    
                    if let url = result.profilePicture{
                        imageURL = url
                    }
                    
                    
                }
            }
        }
    }
}

struct PersonalInfoSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInfoSettingsView()
    }
}
