//
//  ComponentView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI

struct ComponentView: View {
    var body: some View {
//        ZStack {
//            Color(hex: "FFFCF1")
//                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    Rectangle()
                        .cornerRadius(10, corners: [.topLeft, .topRight])
                        .frame(width:393, height: 95)
                        .foregroundColor(Color(hex: "FAC0B5"))
                    Text("요소")
                        .foregroundColor(Color(hex: "FFFCF1"))
                        .font(.system(size: 34))
                        .fontWeight(.black)
                        .padding(.trailing, 280)
                        .padding(.top, 30)
                }
                
                Spacer()
                
               
            }
//        }
    }
}

#Preview {
    ComponentView()
}
