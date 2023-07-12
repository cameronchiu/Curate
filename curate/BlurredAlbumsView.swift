//
//  BlurredAlbumsView.swift
//  curate
//
//  Created by Cameron Chiu on 7/12/23.
//

import SwiftUI

struct BlurredAlbumsView: View {
    
    @State private var isTouched = false
    @State private var selectedItemIndex = 0
    
    var tracks: [Track]
    var colors: [Color]{
        return tracks.map{extractColor($0.album.image)}
    }
    let barHeight = 75.0
    
    
    var body: some View {
        ZStack{
            if isTouched{
                MiniAlbumScrollView(tracks: tracks)

                
            }
            else{
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: colors,
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(height: barHeight)
                    .cornerRadius(10)
            }
                
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    isTouched = true
                })
                .onEnded({ _ in
                    isTouched = false
                })
        )
        
            
        
    }
    
    func extractColor(_ urlString: String) -> Color{
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    return Color(image.averageColor!)
                }
            }
        }
        return Color(.black)
    }
    
}

struct BlurredAlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        BlurredAlbumsView(tracks:  Track.grabXTracks(lim: 10))
    }
}
