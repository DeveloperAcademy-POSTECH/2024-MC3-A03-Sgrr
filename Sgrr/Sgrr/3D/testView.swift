//
//  testView.swift
//  Sgrr
//
//  Created by dora on 7/31/24.
//

import SwiftUI

struct testView: View {
    
   
    @State private var cakeImage: CGImage?
    
    var body: some View {
        VStack {
            
            Cake3DView(cakeImage: $cakeImage)
            CakeCanvasView(cakeImage: $cakeImage)
        }
       
    }
}

#Preview {
    testView()
}


