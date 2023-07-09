//
//  User.swift
//  curate
//
//  Created by Cameron Chiu on 6/24/23.
//

import Foundation

struct User{
    var id: UUID
    var username: String
    
    init(_ username: String){
        self.id = UUID()
        self.username = username
    }
}
