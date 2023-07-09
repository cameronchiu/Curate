//
//  JukeBoxView.swift
//  curate
//
//  Created by Cameron Chiu on 6/28/23.
//

import SwiftUI
import Foundation


struct MiniAlbumScrollView: View {
    
    var tracks: [Song]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(tracks) { track in
                    VStack {
                        GeometryReader { geo in
                            Image(track.albumCoverString)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - UIScreen.main.bounds.width/3) / 8), axis: (x: 0, y: 1, z: 0))
                                .frame(width: 200, height: 120)
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
        MiniAlbumScrollView(tracks: DataService.songRecs)
    }
}
