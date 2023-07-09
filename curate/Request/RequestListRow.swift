//
//  RequestListRow.swift
//  curate
//
//  Created by Cameron Chiu on 6/23/23.
//

import SwiftUI

struct RequestListRow: View {
    
    var request: Request
    @State var recommended_songs: [Song] = []
    let containerHeight = 85.0
    
    var body: some View {
        // request item contents
        HStack{
            VStack(alignment: .leading){
                Spacer()
                Text("Looking for music that...")
                    .italic()
                    .opacity(0.5)
                    .font(.caption)
                    .foregroundColor(Color("fgColor"))
                Spacer()
                Text(request.prompt)
                    .foregroundColor(Color("fgColor"))
                    .font(.headline)
                Spacer()
                // genre tags
                HStack{
                    GenreTags(genreTags: request.genreTags, thresh: 200)
                    Spacer()
                    ForEach(0..<3){ i in
                        let color = i < recommended_songs.count ? recommended_songs[i].avgColor : .gray
                        Circle()
                            .foregroundColor(Color(color))
                            .frame(width: 10, height: 26)
                            .padding(-1)
                        
                    }
                    
                }
                Spacer()
                
                    
                
                
            }
            
            

            
        }
        // request item attributes
        
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .frame(height: containerHeight)
        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color("fgColor")))
        
        

        
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .onAppear(){
        recommended_songs = request.recommendations.compactMap{ rec in
                DataService.getSong(withID: rec.songID)
            }
        }
    }
}

struct RequestListRow_Previews: PreviewProvider {
    static var previews: some View {
        RequestListRow(request: DataService.requests[3])
    }
}
