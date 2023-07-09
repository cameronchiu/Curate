//
//  RequestItem.swift
//  curate
//
//  Created by Cameron Chiu on 6/23/23.
//

import Foundation


class Request: Identifiable{
    var id:UUID
    var userID:UUID
    var prompt:String
    var genreTags:[Genre]
    var recommendations:[Recommendation] = []
    
    init(_ prompt:String, genreTags:[Genre]) {
        id = UUID()
        userID = UUID()
        self.prompt = prompt
        self.genreTags = genreTags
    }
    
    init(_ prompt:String) {
        id = UUID()
        userID = UUID()
        self.prompt = prompt
        self.genreTags = [Genre("Any")]
    }
    
}
