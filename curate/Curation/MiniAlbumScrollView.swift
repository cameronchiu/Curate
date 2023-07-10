//
//  JukeBoxView.swift
//  curate
//
//  Created by Cameron Chiu on 6/28/23.
//

import SwiftUI
import Foundation


struct MiniAlbumScrollView: View {
    
    var tracks: [Track]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(tracks, id: \.self.id) { track in
                    VStack {
                        GeometryReader { geo in
                            AsyncImage(url: URL(string: track.album.image)){ phase in
                                switch phase{
                                case .empty: ProgressView()
                                case .failure(let error): Text("Error \(error.localizedDescription)")
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                        .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - UIScreen.main.bounds.width/3) / 8), axis: (x: 0, y: 1, z: 0))
                                        .frame(width: 200, height: 120)
                                @unknown default: EmptyView()
                                }
                                
                                
                            }
                                
                        }
                        .frame(width: 95, height: 120)
                    }
                }
            }
            .offset(CGSize(width: -100, height: 0))
        }
//        .border(Color.black, width: 1)
    }
}

struct MiniAlbumScrollView_Previews: PreviewProvider {
    static var previews: some View {
        MiniAlbumScrollView(tracks: Track.grabXTracks(lim: 10))
    }
}
