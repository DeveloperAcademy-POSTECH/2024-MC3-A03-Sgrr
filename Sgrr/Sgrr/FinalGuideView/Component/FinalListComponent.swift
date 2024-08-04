//
//  FinalKeywordListComponent.swift
//  Sgrr
//
//  Created by Lee Wonsun on 8/4/24.
//

import SwiftUI

struct FinalListComponent: View {
    
    @State var orderMenu: String = "컨셉"
    @State var listNum: Int = 1
    @State var keyword: String = "평화로운 쥬라기 공원"
    @State var place: String = "옆면"
    @State var isElement: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - 컨셉, divider
            VStack(alignment: .leading, spacing: 0) {
                Text("\(orderMenu)")
                    .font(.finalFormTitle)
                    .foregroundStyle(.main)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                
                Rectangle()
                    .frame(width: 361, height: 2)
                    .foregroundStyle(.main)
            }
            .padding(.bottom, 10)
            
            // MARK: - 리스트 내용
            VStack(spacing: 11) {
                ForEach(0..<listNum) { count in
                    HStack(spacing: 0) {
                        // 숫자 넘버
                        ZStack(alignment: .center) {
                            Circle()
                                .frame(width: 18)
                                .foregroundStyle(.clear)
                                .overlay (
                                    Circle()
                                        .stroke(Color(.main), lineWidth: 2)
                                        .frame(width: 18))
                            
                            Text("\(isElement ? count+2 : count+1)")
                                .font(.custom("SFProRounded-Semibold", size: 13))
                                .foregroundStyle(.main)
                        }
                        .padding(.leading, 35)
                        .padding(.trailing, 8)
                        
                        // 키워드
                        Text("\(keyword)")
                            .font(.finalTextList)
                        
                        Spacer()
                        
                        // 옆면, 윗면 뱃지
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: 29, height: 18)
                                .foregroundStyle(place == "옆면" ? .round : .top)
                            
                            Text("\(place)")
                                .font(.badgeText)
                                .foregroundStyle(place == "옆면" ? .main : .bg)
                        }
                        .padding(.trailing ,24)
                        .opacity(isElement ? 100 : 0)
                    }
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.bg
        
        FinalListComponent()
    } .ignoresSafeArea()
}
