//
//  NavBar.swift
//  curate
//
//  Created by Cameron Chiu on 6/23/23.
//

import SwiftUI



struct NavBar: View {
    

    static let pages: [String] = ["ExplorePage", "HomePage"]
    let content = ContentStream()
    @State private var isExpanded = false
    @StateObject var spotifyController = SpotifyController()
    @State private var selectedTab = "RequestsPage"
    var body: some View {
        
        TabView(selection: $selectedTab){

            Group{
                ExploreView(content: content, isExpanded: $isExpanded)
                    .tabItem{
                        Image(systemName: "globe.europe.africa.fill")
                    }
                    .tag("DiscoverPage")
                
                UserCurationsView()
                    .tabItem{
                        Image(systemName: "person.crop.circle.fill")
                    }
                    .tag("HomePage")
                    .onOpenURL { url in
                        spotifyController.setAccessToken(from: url)
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.didFinishLaunchingNotification), perform: { _ in
                        spotifyController.connect()
                    })
//                SongSearch(spotifyController: spotifyController, trackListVM: TrackListViewModel(spotifyController))
//                    .tabItem{
//                        Image(systemName: "magnifyingglass")
//                    }
            }
            .toolbarBackground(Color("fgColor"), for: .navigationBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbar(isExpanded ? .hidden : .visible, for: .tabBar)
            
        }
        .accentColor(Color("fgColor"))
        .environmentObject(spotifyController)
        

    }
        
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
