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
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var trackName: String = ""
    @State private var trackList: [Track] = []
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                TextField("Track Name", text: $trackName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    addTrack()
                }) {
                    Text("Add Track")
                }
            }
            
            List(trackList, id: \.id) { track in
                Text(track.name)
            }
            
            Button(action: {
                saveCuration()
            }) {
                Text("Save Curation")
            }
        }
        .padding()
    }
    
    private func addTrack() {
//        let newTrack = Track(id: UUID(), name: trackName)
//        trackList.append(newTrack)
//        trackName = ""
    }
    
    private func saveCuration() {
        let curation = Curation(title: name, description: description, tracks: trackList)
        content.stream.append(.curation(curation))
        isPresented = false
        Task.init{
            await curation.addToDB()
        }
        
    }
    
}

struct BuildCurationView_Previews: PreviewProvider {
    static var previews: some View {
        BuildCurationView(isPresented: .constant(true), content: ContentStream())
    }
}
