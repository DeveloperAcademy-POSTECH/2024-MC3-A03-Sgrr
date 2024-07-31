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
            VStack {
                
                Cake3DView(cakeImage: $cakeImage)
                    .frame(height: 300)
                    .background(Color.gray.opacity(0.1))
                
                Divider() 
                
                
                CakeCanvasView_test(cakeImage: $cakeImage)
            }
        }
    }
}

