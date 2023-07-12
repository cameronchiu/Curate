//
//  curateApp.swift
//  curate
//
//  Created by Cameron Chiu on 6/23/23.
//

import SwiftUI

@main
struct curateApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // CC
    let persistenceController = PersistenceController.shared
    @StateObject var spotify: Spotify = Spotify()
    
    init(){
//        _spotify = StateObject(wrappedValue: Spotify())
    }

    var body: some Scene {
        WindowGroup {
            NavBar()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(spotify)
        }
        
    }
}
