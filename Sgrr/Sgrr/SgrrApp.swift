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
    
    @StateObject var router = Router()


    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(router)
        }
    }
}
