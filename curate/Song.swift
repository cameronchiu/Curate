//
//  Song.swift
//  curate
//
//  Created by Cameron Chiu on 6/23/23.
//

import SwiftUI
import UIImageColors
import Foundation

struct Song: Identifiable, Hashable{
    var id: UUID
    var title: String
    var albumTitle: String
    var albumCoverString: String // tbc
    var artistName: String
    var releaseYear: Int
    var tags:[Genre]
    // colors
    var bg_color: UIColor
    var prim_color: UIColor
    var sec_color: UIColor
    var det_color: UIColor
    var avgColor: UIColor
    
    
    init(_ title: String, _ artistName: String, _ albumTitle: String, _ albumCoverString: String, _ genreNames: [String], _ releaseYear: Int){
        self.id = UUID()
        self.title = title
        self.albumTitle = albumTitle
        self.albumCoverString = albumCoverString
        self.artistName = artistName
        self.tags = Genre.stringsToGenres(genreNames)
        self.releaseYear = releaseYear
        
//        if let colors = UIImage(named: albumCoverString)?.getColors(){
//            self.bg_color = colors.background
//            self.prim_color = colors.primary
//            self.sec_color = colors.secondary
//            self.det_color = colors.detail
//        }
//        else{
            self.bg_color = UIColor(Color("fgColor"))
            self.prim_color = UIColor(Color("bgColor"))
            self.sec_color = UIColor(Color("bgColor"))
            self.det_color = UIColor(Color("bgColor"))
            
//        }
        self.avgColor = UIImage(named: albumCoverString)?.averageColor ?? .red
        
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(releaseYear)
        
    }
    
    // Implement the equality operator (==)
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.releaseYear == rhs.releaseYear
    }
}
