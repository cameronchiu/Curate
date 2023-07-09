//
//  MustHearListView.swift
//  curate
//
//  Created by Cameron Chiu on 6/28/23.
//

import SwiftUI

struct MustHearListRow: View {
    
    
    @ObservedObject var mustHear: MustHear
    @State var buttonLiked = false
    @State var song = Song("Title", "ArtistName", "AlbumName", "placeholder", ["Genre1", "Genre2"], 1000)
    @State var user = User("ExampleUser")
    @State var numLikes: Int = -1

    
    static let albumCoverSize = 100.0
    
    
    
    var body: some View {
        HStack{
            
            VStack(alignment: .leading){
                Text("Must-hear")
                    .italic()
                    .opacity(0.75)
                    .font(.caption)
                    .foregroundColor(Color("fgColor"))
                
                Spacer()
                

                HStack{
                    Spacer()
                    VStack{
                        Text(song.title)
                            .foregroundColor(Color("fgColor"))
                            .font(.headline)
                            .lineLimit(1)
                        Text(song.albumTitle)
                            .foregroundColor(Color("fgColor"))
                            .font(.footnote)
                            .lineLimit(1)
                    }
                    Spacer()
                    
                }
                
  

                
                Spacer()
                
                Text(user.username)
                    .font(.caption2)
                    .foregroundColor(Color("fgColor"))
                
                
            }
//            .border(Color.white, width: 1)
            
//            Spacer()
            
            // Image
            Image(song.albumCoverString)
                .resizable()
                .frame(
                    width: MustHearListRow.albumCoverSize,
                    height: MustHearListRow.albumCoverSize)
//                .border(Color.white, width: 1)
            
//            Spacer()
            
            VStack(alignment: .leading){
                Text("")
                Spacer()
                HStack{
                    Spacer()
                    VStack(alignment: .leading){
                        Text(song.artistName)
                            .foregroundColor(Color("fgColor"))
                            .font(.headline)
                        Text(String(song.releaseYear))
                            .fontWeight(.heavy)
                            .foregroundColor(Color("fgColor"))
                            .font(.footnote)
                    }
                    .lineLimit(1)
                    
                    Spacer()
         
                    
                    // heart
                    VStack(alignment: .center){
                        Text(String(numLikes))
                            .font(.system(size: 9))
                            .fontWeight(.bold)
                            .lineLimit(1)
                        Button{
                            buttonLiked.toggle()
                            mustHear.numLikes += buttonLiked ? 1 : -1
                            print("Button pressed")
                            
                        }label:{
                            Image(systemName: buttonLiked ? "heart.fill" : "heart")
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        
                        
                    }
                    .foregroundColor(Color("fgColor"))
                    .opacity(0.7)
                    Spacer()

                    
                    
                    
                }
                Spacer()
                HStack{
                    Spacer()
                    GenreTags(genreTags: song.tags, thresh: 140)
                    
                }
                
                
                
            }
//            .border(Color.white, width: 1)
            
        }
       
            
        // container attributes
        
        .padding(10.0)
        .background(Rectangle()
            .foregroundColor(Color("bgColor"))
            .opacity(1)
            .cornerRadius(25)
            .border(Color("fgColor"), width: 1)
        )
    
        
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        
        .onAppear(){
            // Call for the data
            if let fetchedUser = DataService.getUser(withID: mustHear.userID) {
                user = fetchedUser
            }
            
            if let fetchedSong = DataService.getSong(withID: mustHear.songID) {
                song = fetchedSong
            }
            numLikes = mustHear.numLikes
        }
    }
}

struct MustHearListView_Previews: PreviewProvider {
    static var previews: some View {
        MustHearListRow(mustHear: DataService.mustHears[0])
    }
}
