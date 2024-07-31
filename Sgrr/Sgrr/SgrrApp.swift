//
//  SgrrApp.swift
//  Sgrr
//
//  Created by dora on 7/25/24.
//

// SgrrApp.swift
import SwiftUI

@main
struct SgrrApp: App {
    @State private var cakeImage: CGImage?

    var body: some Scene {
        WindowGroup {

            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            //Cake3DView()
            Canvas()
            //NuggiedItemCell()

        }
    }
}

