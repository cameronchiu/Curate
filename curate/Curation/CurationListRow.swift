//
//  PairingListRow.swift
//  curate
//
//  Created by Cameron Chiu on 6/24/23.
//

import SwiftUI
import UIImageColors

struct CurationListRow: View {
    
   
    @EnvironmentObject var spotify: Spotify
    var itemIdx: Int
    @Binding var selectedItemIdx: Int
    @Binding var isExpanded: Bool
    @State private var childExpanded: Bool = false
    @State private var trackSearchPresented = false
    
    @ObservedObject var curation: Curation
//    @State var tracksWithRanks: [(Track, Int)] = []
    @State var albumImgStrings: [String] = ["placeholder"]
    
    @State var buttonLiked = false
    @State var title: String = "Song Title"
    @State var description: String = "Prompt"
    @State var tags: [Genre] = [Genre("Example Genre")]
    @State var userName: String = "userexample"
    @State var numLikes: Int = -1
    @State var containerColor: UIColor = UIColor(Color("fgColor"))
    @State var textColor: UIColor = UIColor(Color("bgColor"))

    
    
    static var containerHeight = 300.0
    static let albumCoverSize = containerHeight * 1/3
    
    
    
    var body: some View {

        ZStack{
            
            Rectangle()
                .frame(height: 230)
                .onTapGesture{
                    withAnimation{
                        isExpanded = true// communicate to parent that view is expanded
                        childExpanded = true// change this view accordingly
                        selectedItemIdx = itemIdx
                        print("Expanding Curation!")
                    }
                    
                }
                .foregroundColor(Color.black.opacity(0.00001))
            
            VStack(alignment: .center, spacing:0){
                Spacer().frame(height: childExpanded ? 80 : 0)
                // "Curation", (+),  (x)
                HStack(alignment: .top){
                    HStack(spacing: 0){Text("Curation"); if childExpanded{Text(" by \(userName)")}}
                        .italic()
                        .opacity(0.75)
                        .padding(1)
                        .font(.caption)
                        .foregroundColor(Color(textColor))
                    Spacer()
                    VStack{
                        if childExpanded{
                            Button(){
                                withAnimation{
                                    isExpanded = false
                                    childExpanded = false
                                }
                                
                            }label:{
                                Image(systemName: "multiply.circle")
                                    .font(.system(size: 30))
                                    .fontWeight(.ultraLight)
                                    .foregroundColor(Color(textColor))
                                
                            }
                            Spacer().frame(height: 10)
                        }
                        
                        Button(){
                            
                            
                        }label:{
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30))
                                .fontWeight(.ultraLight)
                                .foregroundColor(Color(textColor))
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                }
                Spacer().frame(height: 20)
            
                
                // Title, Description
                TitleDescription(title, description, textColor)
                
                
                // Expanded View
                if childExpanded{
                    Spacer().frame(height: 20)
                    // Suggest Track Button
                    Button(){
                        trackSearchPresented = true
                        
                    }label:{
                        Text("Suggest Track")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .foregroundColor(Color(containerColor))
                    }
                    .padding()
                    .background(
                        Rectangle()
                            .foregroundColor(Color(textColor))
                            .cornerRadius(20)
                    )
                    
                    Spacer().frame(height: 20)
                    
                    // Genre list
                    GenreSearchList(tags: Genre.allGenres)
  
                    
                    Spacer().frame(height: 20)
                    
                    // Tracks
                    ScrollView{
                        LazyVStack{
                            ForEach(curation.tracksWithRanks.indices, id: \.self){ idx in
                                ExpandedTrackListItem(curation: curation, idx: idx, textColor: textColor)
                            }
                        }
                    }
                    
                    // Track Search
                    .sheet(isPresented: $trackSearchPresented){
                        SongSearch(curation: curation, directAdd: true, isPresented: $trackSearchPresented)
                    }
                    
                }
                else{
                    Spacer()
                    BlurredAlbumsView(tracks: curation.tracksWithRanks.map{$0.0})
                    Spacer()
                    // User Name + Genres
                    HStack(spacing: 0){
                        Text(userName)
                            .font(.caption2)
                            .foregroundColor(Color(textColor))
                        Spacer()
                        GenreTags(genreTags: tags, thresh: 250)
                        Spacer()
                            .frame(width: 20)
                    }
                }

            }
            
            
            // heart
            if !childExpanded{
                HStack{
                    Spacer()
                    VStack(alignment: .center){
                        Text(String(curation.numLikes))
                            .font(.system(size: 9))
                            .fontWeight(.bold)
                            .lineLimit(1)
                        Button{
                            buttonLiked.toggle()
                            curation.numLikes += buttonLiked ? 1 : -1
                            print("Button pressed")
                            
                        }label:{
                            Image(systemName: buttonLiked ? "heart.fill" : "heart")
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        
                        
                    }
                    .foregroundColor(Color(textColor))
                }
                
            }
            
            
            
            
            
        }
            
            
            
        
        // container attributes
        .frame(height: childExpanded ? UIScreen.main.bounds.size.height: CurationListRow.containerHeight )
        .padding(.vertical, 15)
        .padding(.horizontal, 20)
        .background(
            Rectangle()
            .foregroundColor(Color(containerColor))
            .opacity(1)
            .cornerRadius(25)
        )
    
        
//        .listRowSeparator(.hidden)
//        .listRowBackground(Color.clear)
        
        .onAppear(){
            // Call for the data
            title = curation.title
            description = curation.description
            tags = curation.tags
            numLikes = curation.numLikes
            containerColor = curation.color
//            tracksWithRanks = curation.tracksWithRanks
            textColor = containerColor.assessTextColor()
            
        }

        
        
    }
    
    

    
    
}


@ViewBuilder
func TitleDescription(_ title: String, _ description: String, _ textColor: UIColor) -> some View{
    Text(title)
        .fontWeight(.bold)
        .font(.headline)
        .foregroundColor(Color(textColor))
    Spacer().frame(height: 10)
    Text(description)
        .font(.caption)
        .foregroundColor(Color(textColor))
}


struct ExpandedTrackListItem: View {
    var curation: Curation
    var idx: Int
    var textColor: UIColor
    
    @State var buttonLiked: Bool = false
    
    var body: some View{
        BlurredTrackView(track: curation.tracksWithRanks[idx].0)
    }
}


struct CurationListRow_Previews: PreviewProvider {
    static let curationExample = Curation.getAllCurations()[0]
    static var previews: some View {
        return CurationListRow(itemIdx: 0, selectedItemIdx: .constant(0), isExpanded: .constant(true), curation: curationExample)
    }
}
