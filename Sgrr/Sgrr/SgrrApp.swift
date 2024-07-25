//
//  SgrrApp.swift
//  Sgrr
//
//  Created by dora on 7/25/24.
//

import SwiftUI

@main
struct SgrrApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
