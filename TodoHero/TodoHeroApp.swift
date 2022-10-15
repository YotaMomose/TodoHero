//
//  TodoHeroApp.swift
//  TodoHero
//
//  Created by Apple on 2022/10/15.
//

import SwiftUI

@main
struct TodoHeroApp: App {
    let persistenceController = PersistenceController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
