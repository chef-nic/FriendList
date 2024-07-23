//
//  ContentView.swift
//  FriendList
//
//  Created by Nicholas Johnson on 7/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationStack {
            List(users, id: \.id) { user in
                HStack {
                    Image(systemName: "circle.fill")
                        .foregroundStyle(user.isActive ? .green : .gray)
                    NavigationLink(user.name) {
                        DetailView(user: user)
                    }
                    .foregroundStyle(.primary)
                }
            }
            .navigationBarTitle("Friend List")
            .onAppear {
                Task {
                    await fetchUsers()
                }
            }
        }
    }
    
    func fetchUsers() async {
        if users.isEmpty {
            // URL Session https://www.hackingwithswift.com/samples/friendface.json
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let users = try decoder.decode([User].self, from: data)
                self.users = users
            } catch {
                print("Error decoding users: \(error)")
                users = []
            }
        } else {
            return
        }
    }
}

#Preview {
    ContentView()
}

struct DetailView: View {
    var user: User
    
    var body: some View {
        List {
            Text("Name: \(user.name)")
            Text("Age: \(user.age)")
            Text("Company: \(user.company)")
            Text("Email: \(user.email)")
            Text("Address: \(user.address)")
            Text("About: \(user.about)")
            Text("Registered: \(user.registered.formatted())")
            Text("Tags: \(user.tags.joined(separator: ", "))")
            Section {
                ForEach(user.friends, id: \.id) { friend in
                    Text(friend.name)
                }
            } header: {
                Text("Friends")
            }
        }
    }
}
