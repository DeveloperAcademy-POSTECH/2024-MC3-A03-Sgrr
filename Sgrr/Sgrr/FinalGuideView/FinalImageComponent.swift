//
//  GuideImageComponent.swift
//  Sgrr
//
//  Created by Lee Wonsun on 8/1/24.
//

import SwiftUI

struct GuideImageComponent: View {
    
    @State var num: Int = 1
    
    var body: some View {
        ZStack {
            //둥근 사각형
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 117, height: 117)
                .foregroundStyle(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.main), lineWidth: 2)
                        .frame(width: 117, height: 117))
            
            // 원형 숫자
            ZStack(alignment: .center) {
                Circle()
                    .frame(width: 20)
                    .foregroundStyle(.white)
                    .overlay(
                        Circle()
                            .stroke(Color(.main), lineWidth: 2)
                            .frame(width: 20))
                
                Text("\(num)")
                    .font(.finalNumber)
                    .foregroundStyle(.main)
            }
            .padding(.trailing, 115)
            .padding(.bottom, 105)
        }
    }
}

#Preview {
    ZStack {
        Color.bg
        GuideImageComponent()
    } .ignoresSafeArea()
}
