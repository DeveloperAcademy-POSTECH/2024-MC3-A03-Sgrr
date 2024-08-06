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
    let managedObject = CoredataManager.shared
    
    @StateObject var router = Router()


    var body: some Scene {
        WindowGroup {
            test()
                .environment(\.managedObjectContext, managedObject.context)
                .environment(cake)
                .environmentObject(router)
        }
    }
}
