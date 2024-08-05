//
//  SgrrApp.swift
//  Sgrr
//
//  Created by dora on 7/25/24.
//

import SwiftUI
import Observation

@main
struct SgrrApp: App {
    @State private var cake = Cake()
    @State private var arrayCapacity = ArrayCapacity()
    let managedObject = CoredataManager.shared
    
    @StateObject var router = Router()


    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, managedObject.context)
                .environment(cake)
                .environment(arrayCapacity)
                .environmentObject(router)
        }
    }
}
