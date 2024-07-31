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
                .frame(height: 300)
                .background(Color.gray.opacity(0.1))
            
            Divider()
            
            
            CakeCanvasView_test(cakeImage: $cakeImage)
        }
       
    }
}

#Preview {
    testView()
}
