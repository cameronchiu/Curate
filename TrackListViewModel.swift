//
//  MovieListViewModel.swift
//  MovieSearchApp
//
//  Created by Mohammad Azam on 6/23/21.
//

import Foundation

@MainActor
class TrackListViewModel: ObservableObject {
    
    var spotifyController: SpotifyController
    
    init(_ spotifyController: SpotifyController){
        self.spotifyController = spotifyController
    }
   
    @Published var tracks: [TrackViewModel] = []
    func search(name: String) -> Void {
        self.spotifyController.getTracks(searchTerm: name){ result in
            switch result{
            case .success(let tracks):
                DispatchQueue.main.async{
                    self.tracks = tracks.map(TrackViewModel.init)
                }
            case .failure(let error):
                print("Failed to get tracks with error \(error)")
            }
        
        }
    }
    
}


struct TrackViewModel {
    
    let track: Track
    
    var title: String {
        track.name
    }
    
    
    var albumCoverURL: URL? {
        URL(string: track.album.images.first?.url ?? "")
    }
    
    
    var artist: String {
        track.artists.first!.name
    }
}
