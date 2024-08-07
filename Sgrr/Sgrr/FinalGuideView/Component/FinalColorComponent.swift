//
//  FinalColorComponent.swift
//  Sgrr
//
//  Created by Lee Wonsun on 8/4/24.
//

import SwiftUI

struct FinalColorComponent: View {
    
    @State var selectedBg: String = "FF5733"
    @State var selectedLetter: String = "FF5733"
    // TODO: 티나 헥스코드 어떻게 보여줬는지 물어보기
    
  
    
    var body: some View {
        VStack {
            // MARK: - 컨셉, divider
            VStack(alignment: .leading, spacing: 0) {
                Text("컬러")
                    .font(.finalFormTitle)
                    .foregroundStyle(.main)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                
                Rectangle()
                    .frame(width: 361, height: 2)
                    .foregroundStyle(.main)
            } .padding(.bottom, 10)
            
            // MARK: - 색상 / hex코드 / 뱃지
            HStack(spacing: 24) { 
                HStack(spacing: 0) {
                    Circle()
                        .frame(width: 26)
                        .foregroundStyle(Color(hex: selectedBg))
                        .shadow(radius: 4)
                        .padding(.trailing, 12)
                    
                    Text("#\(selectedBg)")
                        .font(.hexText)
                        .foregroundStyle(.hex)
                        .padding(.trailing, 20)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .frame(width: 35, height: 18)
                            .foregroundStyle(.main)
                        
                        Text("배경")
                            .font(.badgeText)
                            .foregroundStyle(.bg)
                    }
                }
                
                HStack(spacing: 0) {
                    Circle()
                        .frame(width: 26)
                        .foregroundStyle(Color(hex: selectedLetter))
                        .shadow(radius: 4)
                        .padding(.trailing, 12)
                    
                    Text("#\(selectedLetter)")
                        .font(.hexText)
                        .foregroundStyle(.hex)
                        .padding(.trailing, 20)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .frame(width: 35, height: 18)
                            .foregroundStyle(.main)
                        
                        Text("레터링")
                            .font(.badgeText)
                            .foregroundStyle(.bg)
                    }
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.bg
        FinalColorComponent()
    } .ignoresSafeArea()
}
