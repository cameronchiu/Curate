//
//  Spotify.swift
//  curate
//
//  Created by Cameron Chiu on 7/10/23.
//

import Foundation
import Combine

class Spotify: ObservableObject{
    var controller: SpotifyController
    @Published var searcher: TrackListViewModel
    
    init(){
        self.controller = SpotifyController()
        self.searcher = TrackListViewModel(self.controller)
    }
}
