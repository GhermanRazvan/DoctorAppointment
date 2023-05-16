//
//  Login2View.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 16.05.2023.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @AppStorage("email") var userEmail: String = ""
    @State var isLogedin: Bool = false
    @State var showRegister: Bool = false
    @State var email: String = ""
    @State var password: String = ""
    
    private func isValidPassword(_ password: String) -> Bool{
        //minimum 6 char long
        //1 uppercase character\
        //1 special cahr
        
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        return passwordRegex.evaluate(with: password)
        
    }
    
    var body: some View {
        
        
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
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
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
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
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
            Button {
                showRegister.toggle()
            } label: {
                Text("Don't have an account?")
                    .foregroundColor(.black.opacity(0.7))
            }
            .sheet(isPresented: $showRegister) {
                RegiesterView()
            }
            
            Spacer()
            Spacer()
            
            Button {
                userEmail = email
                Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                    if let error = error {
                        print (error)
                        return
                    }
                    if let authResult = authResult{
                            userEmail = authResult.user.email!
                            isLogedin = true
                    }
                }
            } label: {
                
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
            .fullScreenCover(isPresented: $isLogedin) {
                StartView()
            }
        }.onAppear{
           if Auth.auth().currentUser != nil {
                isLogedin = true
            }
        }
    }
}
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
