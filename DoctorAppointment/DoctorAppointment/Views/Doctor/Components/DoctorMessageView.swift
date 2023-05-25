//
//  DoctorMessageView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 25.05.2023.
//

import SwiftUI

struct DoctorMessageView: View {
    @AppStorage("email") var userEmail: String = ""
    @State var messages: [Message] = []
    @State var sendMessage: String = ""
    var pacientID: String
    
    var body: some View {
        VStack{
            
            
            List{
                ForEach(messages){ message in
                    HStack(alignment: .bottom, spacing: 15){
                        if message.fromUserID == userEmail{
                            Spacer()
                            ContentMessageView(contentMessage: message.messageText, isCurrentUser: true)
                            
                        }else {
                            ContentMessageView(contentMessage: message.messageText, isCurrentUser: false)
                        }
                    }
                }
                
            }
            HStack{
                
                
                TextField("Send message", text: $sendMessage)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                Button {
                    let message = Message(fromUserID: userEmail, toUserID: pacientID, date: Date(), messageText: sendMessage)
                    if sendMessage != ""{
                        MessageManager.shared.addMessage(message: message)
                        messages.append(message)
                        sendMessage = ""
                    }
                    
                } label: {
                    Image(systemName: "paperplane")
                }

            }
            
        }
        .navigationTitle(pacientID)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            MessageManager.shared.getAllMessagedForUser(user1: pacientID, user2: userEmail) { rez in
                if let rez = rez{
                    messages = rez.sorted{
                        $0.date < $1.date
                    }
                }
            }
        }
    }
}

struct DoctorMessageView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorMessageView(pacientID: "")
    }
}
