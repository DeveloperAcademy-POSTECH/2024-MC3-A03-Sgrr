//
//  TinaComponentView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 8/7/24.
//

import SwiftUI

struct TinaComponentView: View {
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .frame(width: 393, height: 95)
                    .foregroundColor(Color(hex: "FAC0B5"))
                Text("요소")
                    .foregroundColor(Color(hex: "FFFCF1"))
                    .font(.system(size: 34))
                    .fontWeight(.black)
                    .padding(.trailing, 280)
                    .padding(.top, 30)
            }
        }
        
        
    }
}

#Preview {
    TinaComponentView()
}
