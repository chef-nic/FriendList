//
//  Friend.swift
//  FriendList
//
//  Created by Nicholas Johnson on 7/22/24.
//

import Foundation
import SwiftData

@Model
class Friend: Codable {
    var id: UUID
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
