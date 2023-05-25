//
//  ChatView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 25.05.2023.
//

import SwiftUI

struct ChatView: View {
    @AppStorage("email") var userEmail: String = ""
    @State var chats: [Chat] = []
    var body: some View {
        NavigationStack{
            List{
                ForEach(chats){ chat in
                    NavigationLink {
                        MessageView(doctorID: chat.doctorID)
                    } label: {
                        Text(chat.doctorID)
                    }

                    
                }
                
            }.navigationTitle("Chat")
        }.onAppear{
            ChatManager.shared.getChatsForPacient(email: userEmail) { rez in
                if let rez = rez{
                    chats = rez
                }
            }
            
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
