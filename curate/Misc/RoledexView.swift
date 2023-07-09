//
//  RoledexView.swift
//  curate
//
//  Created by Cameron Chiu on 6/28/23.
//

import SwiftUI
import Foundation


struct RoledexView: View {
    // MARK: Animation Properties
    @State var currentSong: Song = DataService.songRecs.first!
       
    var body: some View {
        VStack{
            HeaderView()
            SongSlider()
            
            // MARK: Detail's View
            SongDetailView()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
    }
    
    @ViewBuilder
    func SongDetailView()->some View{
        VStack{
            GeometryReader{
                let size = $0.size
                
                // MARK: Implementing Delayed Slider Effect
                HStack(spacing: 0){
                    ForEach(DataService.songRecs){ song in
                        let index = indexOf(song: song)
                        let currentIndex = indexOf(song: currentSong)
                        
                        VStack(alignment: .leading, spacing: 18) {
                            Text(song.title)
                                .font(.largeTitle)
                                .foregroundColor(.black.opacity(0.7))
                                // MARK: Sliding to the Current Index Position with Delay Based on Index
                                .offset(x: CGFloat(currentIndex) * -(size.width + 30))
                                .opacity(currentIndex == index ? 1 : 0)
                                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(currentIndex < index ? 0.1 : 0), value: currentIndex == index)
                            Text("By \(song.artistName)")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .offset(x: CGFloat(currentIndex) * -(size.width + 30))
                                .opacity(currentIndex == index ? 1 : 0)
                                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(currentIndex > index ? 0.1 : 0), value: currentIndex == index)
                        }
                        .frame(width: size.width + 30, alignment: .leading)
                    }
                }
                
                         
            }
            .padding(.horizontal, 15)
            .frame(height: 100)
            .padding(.bottom, 10)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.gray.opacity(0.4))
                GeometryReader{
                    let size = $0.size
                    //MARK: Updating Progress When Ever Current Song is Updated
                    Capsule()
                        .fill(Color(.green))
                        .frame(width:CGFloat(indexOf(song: currentSong)) / CGFloat(DataService.songRecs.count - 1) * size.width)
                        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.75, blendDuration: 0.75), value: currentSong)
                }
            }
            .frame(height: 4)
            .padding(.top, 10)
            .padding([.horizontal, .bottom], 15)
        }
        
        
    }
    
    //MARK: Index
    func indexOf(song: Song)->Int{
        
        if let index = DataService.songRecs.firstIndex(of: song){
            return index
        }
        return 0
        
    }
    
    //MARK: Song Slider
    func SongSlider() -> some View{
        TabView(selection: $currentSong){
            ForEach(DataService.songRecs){song in
                SongView(song: song)
                    .tag(song)
                
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .background{
            Rectangle()
                .foregroundColor(Color(.white))
        }
    }
    //MARK: Book View
    @ViewBuilder
    func SongView(song: Song)-> some View{
        GeometryReader{
            let size = $0.size
            
            // MARK: Animation Calculations
            let rect = $0.frame(in: .global)
            let minX = (rect.minX - 50) < 0 ? (rect.minX - 50) : -(rect.minX - 50)
            let progress = (minX) / rect.width
            // MARK: Your Custom Rotation Angle
            let rotation = progress * 25
            ZStack{
                //MARK: Book Like View
                // With the Help of Isometric View
                // See
                
                IsometricView(depth: 10){
                    Color.white
                }bottom: {
                    Color.white
                } side: {
                    Color.white
                }
                .frame(width: size.width / 1.2, height: size.height / 1.5)
                //MARK: Shadows
                .shadow(color: .black.opacity(0.12), radius: 5, x: 15, y:8)
                .shadow(color: .black.opacity(0.1), radius: 6, x: -10, y:-8)
                
                Image(song.albumCoverString)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width / 1.2, height: size.height / 1.5)
                    .clipped()
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 10, y: 8)
                // MARK: Adding Book Opening Animation
                    .rotation3DEffect(.init(degrees: rotation), axis: (x: 0, y: 1, z: 0), anchor: .leading, perspective: 1)
                
                Text("\(progress)")
                    .font(.largeTitle)
                
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            
        }
        .padding(.horizontal, 50)
        .background{
            Rectangle()
                .foregroundColor(Color(.white))
        }
        
    }
    
    //MARK: Header View
    @ViewBuilder
    func HeaderView() -> some View{
        HStack(spacing: 15){
            Text("Bookio")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.7))
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                
            }label:{
                Image(systemName: "books.vertical")
                
            }
            
            Button {
                
            }label:{
                Image(systemName: "book.closed")
                
            }
        }
    }
    

}

struct RoledexView_Previews: PreviewProvider {
    static var previews: some View {
        RoledexView()
    }
}
