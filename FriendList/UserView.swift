//
//  UserView.swift
//  FriendList
//
//  Created by Nicholas Johnson on 7/23/24.
//

import SwiftUI

struct UserView: View {
    var user: User
    
    var body: some View {
        List {
            Section("About") {
                Text(user.about)
                    .padding(.vertical)
            }
            
            Section("Contact details") {
                Text("Address: \(user.address)")
                Text("Company: \(user.company)")
            }
            
            Section("Friends") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    UserView(user: User.example)
}
