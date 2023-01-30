//
//  ConfirmationView.swift
//  Todo
//
//  Created by mac on 2023/01/11.
//

import SwiftUI

struct ConfirmationView: View {
    @EnvironmentObject var sessionManager : SessionManager
    
    @State var confirmationCode = ""
    
    let username: String
    var body: some View {
        VStack{
            Text("username: \(username)")
            TextField("Confirmation Code", text: $confirmationCode)
            Button("Confirm", action:{
                Task{
                    await sessionManager.confirmSignUp(for: username, with: confirmationCode)
                }
            })
        }
    }
}
