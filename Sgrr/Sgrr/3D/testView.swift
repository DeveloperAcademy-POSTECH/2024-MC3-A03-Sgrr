//
//  testView.swift
//  Sgrr
//
//  Created by dora on 7/31/24.
//

import SwiftUI

struct testView: View {
    @State private var cakeImage: CGImage?
    
    @EnvironmentObject var router: Router


    
    var body: some View {
        VStack {
            Cake3DView(cakeImage: $cakeImage)
            CakeCanvasView(cakeImage: $cakeImage)
            
        }
        .toolbarBackground(Color(hex: "F9F6EB"), for: .navigationBar)
        .toolbar {

            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    router.pop()
                    
                } label: {
                Image(systemName: "chevron.backward")
                        .foregroundColor(Color(hex: "FA5738"))
                        .font(.system(size: 20))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        
       
    }
}

#Preview {
    testView()
}


