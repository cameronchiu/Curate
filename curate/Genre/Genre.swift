//
//  Genre.swift
//  curate
//
//  Created by Cameron Chiu on 6/23/23.
//

import Foundation

struct Genre : Identifiable{
    
    static let allGenreNames:[String] = ["Classical", "Jazz", "Rock", "R&B", "Hip Hop", "Synth", "Electric", "K-Pop", "Rap"]
    static var allGenres:[Genre]{
        return stringsToGenres(allGenreNames)
    }
    
    static func stringsToGenres(_ genreStrings: [String]) -> [Genre]{
        return genreStrings.map{Genre($0)}
    }
    
    var id:UUID
    var name:String
    
    init(_ name:String){
        id = UUID()
        self.name = name
    }
    

}
