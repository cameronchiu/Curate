//
//  NavBar.swift
//  curate
//
//  Created by Cameron Chiu on 6/23/23.
//

import SwiftUI



struct NavBar: View {
    

    static let pages: [String] = ["ExplorePage", "HomePage"]
    var content = ContentStream()
    @State private var isExpanded = false
    @EnvironmentObject var spotify: Spotify
    @State private var selectedTab = "ExplorePage"
    

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
                        spotify.controller.setAccessToken(from: url)
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.didFinishLaunchingNotification), perform: { _ in
                        spotify.controller.connect()
                    })
            }
            .toolbarBackground(Color("fgColor"), for: .navigationBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbar(isExpanded ? .hidden : .visible, for: .tabBar)
            
        }
        .accentColor(Color("fgColor"))
        
        

    }
        
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
