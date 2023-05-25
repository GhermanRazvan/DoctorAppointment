//
//  MessageView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 25.05.2023.
//

import SwiftUI

struct MessageView: View {
    @AppStorage("email") var userEmail: String = ""
    @State var messages: [Message] = []
    @State var sendMessage: String = ""
    var doctorID: String
    
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
                    let message = Message(fromUserID: userEmail, toUserID: doctorID, date: Date(), messageText: sendMessage)
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
        .navigationTitle(doctorID)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            MessageManager.shared.getAllMessagedForUser(user1: doctorID, user2: userEmail) { rez in
                if let rez = rez{
                    messages = rez.sorted{
                        $0.date < $1.date
                    }
                }
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(doctorID: "")
    }
}
