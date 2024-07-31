//
//  OrderFormView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/26/24.
//

import SwiftUI

struct OrderFormView: View {
    
    
    
    var body: some View {
        
        GeometryReader { geo in
            ScrollView {
                
                    
                    LazyVStack {
                        VStack {
                            ColorView()
                        } .frame(height: geo.size.height)
                        VStack {
                            ConceptView()
                        } .frame(height: geo.size.height)
                        VStack {
                            ComponentView()
                        } .frame(height: geo.size.height)
                    }
                
            }
            .background(Color(hex: "FFFCF1"))
        }
    }
}


#Preview {
    OrderFormView()
}
