//
//  RegiesterView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 16.05.2023.
//

import SwiftUI
import FirebaseAuth

struct RegiesterView: View {
    @Environment (\.dismiss) var dismiss
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var firstName: String = ""
    @State private var middleName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    
    private func isValidPassword(_ password: String) -> Bool{
        //minimum 6 char long
        //1 uppercase character\
        //1 special cahr
        
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        
        return passwordRegex.evaluate(with: password)
        
    }
    
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    Text("Create an Account!")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                }
                
                .padding()
                .padding(.top)
                
                Spacer()
                
                Group{
                    HStack{
                        
                        Image(systemName: "person")
                        TextField("First Name",text: $firstName)
                            .autocapitalization(.none)
                        
                        Spacer()
                        
                        if (firstName.count != 0)
                        {
                            Image(systemName:   "checkmark" )
                                .fontWeight(.bold)
                                .foregroundColor( .green )
                            
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius:10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.white)
                    )
                    
                    .padding()
                    
                    HStack{
                        
                        Image(systemName: "person")
                        TextField("Middle Name",text: $middleName)
                            .autocapitalization(.none)
                        
                        Spacer()
                        
                        if (middleName.count != 0)
                        {
                            Image(systemName:   "checkmark" )
                                .fontWeight(.bold)
                                .foregroundColor( .green )
                            
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius:10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.white)
                    )
                    
                    .padding()
                    
                    
                    HStack{
                        
                        Image(systemName: "person")
                        TextField("Last Name",text: $lastName)
                            .autocapitalization(.none)
                        
                        Spacer()
                        
                        if (lastName.count != 0)
                        {
                            Image(systemName:   "checkmark" )
                                .fontWeight(.bold)
                                .foregroundColor( .green )
                            
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius:10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.white)
                    )
                    
                    .padding()
                }
                
                
                HStack{
                    
                    Image(systemName: "phone")
                    TextField("Phone Number",text: $phoneNumber)
                        .autocapitalization(.none)
                    
                    Spacer()
                    
                    if (phoneNumber.count != 0)
                    {
                        Image(systemName:   "checkmark" )
                            .fontWeight(.bold)
                            .foregroundColor( .green )
                        
                    }
                    
                }
                .foregroundColor(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius:10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                )
                
                .padding()
                HStack{
                    
                    Image(systemName: "mail")
                    TextField("Email",text: $email)
                        .autocapitalization(.none)
                        .textInputAutocapitalization(.never)
                    
                    Spacer()
                    
//                    if (email.count != 0)
//                    {
//                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
//                            .fontWeight(.bold)
//                            .foregroundColor(email.isValidEmail() ? .green : .red)
//
//                    }
                }
                .foregroundColor(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius:10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                )
                .padding()
                
                HStack{
                    Image(systemName: "lock")
                    SecureField("Password",text: $password)
                        .autocapitalization(.none)
                    
                    Spacer()
                    
//                    if(password.count != 0)
//                    {
//                        Image(systemName: isValidPassword(password) ? "checkmark" : "xmark")
//                            .fontWeight(.bold)
//                            .foregroundColor(isValidPassword(password) ? .green : .red)
//
//                    }
                    
                    
                }
                .foregroundColor(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius:10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                )
                .padding()
                Button(action: {
                    
                    dismiss()
                }){
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                }
                
                Spacer()
                Spacer()
                
                Button{

                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in

                        if let error = error {
                            print(error)
                            return
                        }


                        if authResult != nil {
                            
                            let pacient = Pacient(firstName: firstName, middleName: middleName, lastName: lastName, phoneNumber: phoneNumber, email: email)
                            PacientManager.shared.addPacient(pacient: pacient) { result in
                                if (result == false){
                                    print("Unable to write user to firebase")
                                }                            }
                            UserRoleManager.shared.addUserRole(email: email, role: "pacient")
                            DispatchQueue.main.async {
                                dismiss()
                            }

                        }
                    }
                }label:{
                    Text("Create new Account")
                        .foregroundColor(.black)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                        )
                        .padding(.horizontal)
                }
            }
        }
    }
}

struct RegiesterView_Previews: PreviewProvider {
    static var previews: some View {
        RegiesterView()
    }
}
