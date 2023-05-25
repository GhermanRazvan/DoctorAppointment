//
//  DoctorChatView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 25.05.2023.
//

import SwiftUI

struct DoctorChatView: View {
    @AppStorage("email") var userEmail: String = ""
    @State var chats: [Chat] = []
    var body: some View {
        NavigationStack{
            List{
                ForEach(chats){ chat in
                    NavigationLink {
                        DoctorMessageView(pacientID: chat.pacientID)
                    } label: {
                        Text(chat.pacientID)
                    }

                    
                }
                
            }.navigationTitle("Chat")
        }.onAppear{
            ChatManager.shared.getChatsForDoctor(email: userEmail) { rez in
                if let rez = rez{
                    chats = rez
                }
            }
            
        }
    }
}

struct DoctorChatView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorChatView()
    }
}
