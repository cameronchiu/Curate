//
//  BuildCurationView.swift
//  curate
//
//  Created by Cameron Chiu on 7/8/23.
//

import SwiftUI

struct BuildCurationView: View {
    
    @Binding var isPresented: Bool
    var content: ContentStream // passed in from Explore
    @StateObject var newCuration: Curation = Curation()
//    @State private var name: String = ""
//    @State private var description: String = ""
//    @State private var trackName: String = ""
//    @State private var trackList: [Track] = []
    @State private var trackSearchPresented = false
    
    var body: some View {
        VStack(alignment: .center){
            TextField("Title", text: $newCuration.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Description", text: $newCuration.description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
            Button(){
                trackSearchPresented = true
                                
            }label:{
                Text("Add Track")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("bgColor"))
            }
            .padding()
            .background(
                Rectangle()
                    .foregroundColor(Color("fgColor"))
                    .cornerRadius(20)
            )
            
      
            
            List(newCuration.tracksWithRanks, id: \.self.0.id) { track, _ in
                Text(track.name)
            }
            
            Button(action: {
                saveCuration()
            }) {
                Text("Save Curation")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("bgColor"))
            }
            .padding()
            .background(
                Rectangle()
                    .foregroundColor(Color("fgColor"))
                    .cornerRadius(20)
            )
            
        }
        .padding()
        
        // Track Search
        .sheet(isPresented: $trackSearchPresented){
            SongSearch(curation: newCuration, directAdd: false, isPresented: $trackSearchPresented)
        }
    }
    
    private func addTrack() {
//        let newTrack = Track(id: UUID(), name: trackName)
//        trackList.append(newTrack)
//        trackName = ""
    }
    
    private func saveCuration() {
        content.stream.append(.curation(newCuration))
        isPresented = false
        Task.init{
            await newCuration.addToDB()
        }
        
    }
    
}

struct BuildCurationView_Previews: PreviewProvider {
    static var previews: some View {
        BuildCurationView(isPresented: .constant(true), content: ContentStream())
    }
}
