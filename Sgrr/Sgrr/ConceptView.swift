//
//  ConceptView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI

struct ConceptView: View {
    var body: some View {

            VStack {
                ZStack {
                    Rectangle()
                        .cornerRadius(10, corners: [.topLeft, .topRight])
                        .frame(width:393, height: 95)
                        .foregroundColor(Color(hex: "FA8C76"))
                    Text("컨셉")
                        .foregroundColor(Color(hex: "FFFCF1"))
                        .font(.system(size: 34))
                        .fontWeight(.black)
                        .padding(.trailing, 280)
                        .padding(.top, 30)
                }
                
                Spacer()
                
               
            }

    }
}

#Preview {
    ConceptView()
}
