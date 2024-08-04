//
//  GuideImageComponent.swift
//  Sgrr
//
//  Created by Lee Wonsun on 8/1/24.
//

import SwiftUI

struct GuideImageComponent: View {
    
    @State var num: Int = 1
    var selectedImage: UIImage
    
    var body: some View {
        ZStack {
            //둥근 사각형
            Image(uiImage: selectedImage)
                .resizable()
                .frame(width: 112, height: 112)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.main), lineWidth: 2)
                        .frame(width: 112, height: 112))
            
            // 원형 숫자
            ZStack(alignment: .center) {
                Circle()
                    .frame(width: 16)
                    .foregroundStyle(.white)
                    .overlay(
                        Circle()
                            .stroke(Color(.main), lineWidth: 2)
                            .frame(width: 16))
                
                Text("\(num)")
                    .font(.finalNumber)
                    .foregroundStyle(.main)
            }
            .padding(.trailing, 110)
            .padding(.bottom, 105)
        }
    }
}

#Preview {
    ZStack {
        Color.bg
        GuideImageComponent(selectedImage: UIImage(named: "cakeElement_5")!)
    } .ignoresSafeArea()
}
