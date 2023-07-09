//
//  UserCurationsPage.swift
//  curate
//
//  Created by Cameron Chiu on 6/23/23.
//

import SwiftUI

struct UserCurationsView: View {
    @StateObject var spotifyController = SpotifyController()
    
    var body: some View {
        VStack{
            Button{
                spotifyController.connect()
                
            }label:{
                Text("Connect to Spotify")
            }
        }
    }
}

struct UserCurationsPage_Previews: PreviewProvider {
    static var previews: some View {
        UserCurationsView()
    }
}
