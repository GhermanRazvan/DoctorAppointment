//
//  SendMessageView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 25.05.2023.
//

import SwiftUI

struct SendMessageView: View {
    @AppStorage("email") var userEmail: String = ""
    @State var chatExists: Bool = false
    
    var doctorID: String
    var body: some View {
        Group{
                MessageView(doctorID: doctorID)
            
        }.onAppear{
            let group = DispatchGroup()
            let queue = DispatchQueue(label: "Chat")
            
            group.enter()
            queue.async {
                ChatManager.shared.checkIfChatExists(doctorID: doctorID, pacientID: userEmail) { rez in
                    if let rez = rez{
                        chatExists = rez
                    }
                    group.leave()
                }
            }
            queue.async {
                group.wait()
                if !chatExists{
                    group.enter()
                    let chat = Chat(doctorID: doctorID, pacientID: userEmail)
                    ChatManager.shared.createChat(chat: chat)
                    group.leave()
                }
            }
            
        }
    }
}

struct SendMessageView_Previews: PreviewProvider {
    static var previews: some View {
        SendMessageView(doctorID: "")
    }
}
