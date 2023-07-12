//
//  BlurredTrackView.swift
//  curate
//
//  Created by Cameron Chiu on 7/10/23.
//

import SwiftUI
import UIImageColors

struct BlurredTrackView: View {
    var track: Track
    
    var body: some View {
        ZStack{
            HStack{
                Text(track.name)
                Spacer()
                Text(track.album.all_artists)
                
            }
            .fontWeight(.heavy)
            .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .padding()
            .foregroundColor(.white)
            .background(
                ZStack{
                    AsyncImage(url: URL(string: track.album.image))
                        .blur(radius: 5)
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(0.5)
                }
                
            )
            .cornerRadius(15)
            
        }
        
        
    }
    
    
}

struct BlurredTrackView_Previews: PreviewProvider {
    static let track = Track.grabXTracks(lim: 10)[1]
    static var previews: some View {
        BlurredTrackView(track: track)
    }
}
