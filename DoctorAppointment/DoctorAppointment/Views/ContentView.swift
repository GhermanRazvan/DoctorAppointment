//
//  ContentView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 03.04.2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
   
    @AppStorage("uid") var userID: String = ""
    
    var body: some View {
        
        if userID == "" { 
            AuthView()
        }else {
            Text("Logged In! \nYour user id is \(userID)")
            
            Button(action: {
                let firebaseAuth = Auth.auth()
                do {
                  try firebaseAuth.signOut()
                    withAnimation{
                        userID =  ""    
                    }
                    
                } catch let signOutError as NSError {
                  print("Error signing out: %@", signOutError)
                }
            }){
                Text("Sign out")
            }
        }
        
        
//        .padding()
//        .task{DoctorManager.shared.getAllDoctors { result in
//            switch result{
//            case .success(let doctor):
//                print(doctor)
//            case .failure(let err):
//                print(err)
//            }
//        }}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
