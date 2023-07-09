//
//  Recommendation.swift
//  curate
//
//  Created by Cameron Chiu on 6/23/23.
//

import Foundation
import SwiftUI


class Recommendation{
    var recommenderID: UUID
    var recommendationType: String
    var songID: UUID
    
    

    init(recommenderID: UUID, recommendationType: String, songID: UUID){
        self.recommenderID = recommenderID
        self.recommendationType = "Song"
        self.songID = songID
    }


}
