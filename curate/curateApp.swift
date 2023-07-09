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

    var body: some Scene {
        WindowGroup {
            NavBar()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
