//
//  LoginView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 05.04.2023.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @Binding var currentShowingView :String 
    @AppStorage("uid") var userID: String = ""
    @AppStorage("email") var userEmail: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    
    private func isValidPassword(_ password: String) -> Bool{
        //minimum 6 char long
        //1 uppercase character
        //1 special cahr
        
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        
        return passwordRegex.evaluate(with: password)
        
    }
    
    
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    Text("Welcome Back!")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                }
                
                .padding()
                .padding(.top)
                
                Spacer()
                
                HStack{
                    
                    Image(systemName: "mail")
                    TextField("Email",text: $email)
                        .autocapitalization(.none)
                    
                    Spacer()
                    
                    if (email.count != 0)
                    {
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(email.isValidEmail() ? .green : .red)
                        
                    }
                    
                    
                    
                    
                    
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius:10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                )
                
                .padding()
                
                HStack{
                    Image(systemName: "lock")
                    SecureField("Password",text: $password)
                    
                    Spacer()
                    
                    if(password.count != 0)
                    {
                        Image(systemName: isValidPassword(password) ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(isValidPassword(password) ? .green : .red)
                        
                    }
                    
                    
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius:10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                )
                
                
                
                .padding()
                
                Button(action: {
                    
                    withAnimation() {
                        self.currentShowingView = "signup"
                        
                    }
                    
                }){
                    Text("Don't have an account?")
                        .foregroundColor(.black.opacity(0.7))
                }
                
                Spacer()
                Spacer()
                
                Button{
                    
                    Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                        if let error = error {
                            print (error)
                            return
                        }
                        if let authResult = authResult{
                            print(authResult.user.uid)
                            withAnimation{
                                userID = authResult.user.uid
                                userEmail = authResult.user.email!
                               
                                
                                
                            }
                            
                        }
                        
                       
                      // ...
                    }
                    
                }label:{
                    Text("Sign in")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                        )
                        .padding(.horizontal)
                }
                
                
            }
        }
    }
}





