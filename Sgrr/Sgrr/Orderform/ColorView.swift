//
//  ColorView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI

struct ColorView: View {
    
    @StateObject var backgroundColorData = ColorData(colorTitle: "배경", selectedColor: .white)
    @StateObject var letteringColorData = ColorData(colorTitle: "레터링", selectedColor: .white)
    
        
    var body: some View {
        
//
            VStack {
                ZStack {
                    Rectangle()
                        .frame(width:393, height: 95)
                        .foregroundColor(Color(hex: "FA5738"))
                    Text("컬러")
                        .foregroundColor(Color(hex: "FFFCF1"))
                        .font(.system(size: 34))
                        .fontWeight(.black)
                        .padding(.trailing, 280)
                        .padding(.top, 30)
                }
                
                Spacer()
                
                //LazyHStack
                VStack {
                    HStack {
                        ColorAddView(colorData: backgroundColorData)
                        Spacer()
                        ColorAddView(colorData: letteringColorData)
                    }
                    .padding(.trailing, 22)
                    .padding(.leading, 22)
                    .padding(.top, 22)
                    Spacer()
                }
            }

       
    }
}

#Preview {
   ColorView()
}
