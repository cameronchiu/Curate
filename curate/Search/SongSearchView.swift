import SwiftUI
import SpotifyiOS
import Combine

struct SongSearch: View {
    
    var curation: Curation
    var directAdd: Bool
    @Binding var isPresented: Bool
    @EnvironmentObject var spotify: Spotify
    @State private var searchText: String = ""
    @FocusState private var keyboardFocused: Bool
    
    
    var body : some View{
        NavigationView {
            List(spotify.searcher.tracks, id: \.track.id) { track in
                HStack {
                    AsyncImage(url: track.albumCoverURL
                               , content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 100)
                    }, placeholder: {
                        ProgressView()
                    })
                    VStack(alignment: .leading){
                        Text(track.title)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text(track.artist)
                            .font(.footnote)
                            .fontWeight(.heavy)
                            .foregroundColor(.gray)
                        
                    }
                    
                    
                }
                .onTapGesture{
                    print("Tapping Track")
                    // lower sheet
                    isPresented = false
                    
                    // first add to object if it doesn't already exist
                    curation.addToObj(track: track.track)
                    
                    if directAdd{
                        Task.init{
                            await curation.addTrack(track: track.track)
                        }
                        
                    }
                    
                    
                }
            }.listStyle(.plain)
                .searchable(text: $searchText)
                .onChange(of: searchText) { value in
                    if !value.isEmpty &&  value.count >= 2 {
                        spotify.searcher.search(name: value)
                    } else {
                        spotify.searcher.tracks.removeAll()
                    }
                }
                .focused($keyboardFocused)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        keyboardFocused = true
                    }
                }
            
                .navigationTitle("Tracks")
        }
        
    }

}

struct SongSearch_Previews: PreviewProvider {
    static var previews: some View {
        let curationExample = Curation.getAllCurations()[0]
        SongSearch(curation: curationExample, directAdd: true, isPresented: .constant(true))
    }
}
