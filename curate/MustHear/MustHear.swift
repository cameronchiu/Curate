//
//  MustHear.swift
//  curate
//
//  Created by Cameron Chiu on 6/28/23.
//

import Foundation

class MustHear: ObservableObject{
    var id: UUID
    var numLikes: Int
    var userID: UUID
    var songID: UUID
    
    init(userID: UUID, songID: UUID){
        self.id = UUID()
        self.userID = userID
        self.numLikes = 0
        self.songID = songID
    }
}
