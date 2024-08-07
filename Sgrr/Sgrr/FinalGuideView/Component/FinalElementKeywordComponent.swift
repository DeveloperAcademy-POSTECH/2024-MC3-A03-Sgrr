//
//  FinalKeywordListComponent.swift
//  Sgrr
//
//  Created by Lee Wonsun on 8/4/24.
//

import SwiftUI

struct FinalElementKeywordComponent: View {
    
    @State var isSide: Bool = true
    @State var finalKeyword: [String] = []
    
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - 컨셉, divider
            VStack(alignment: .leading, spacing: 0) {
                Text("컨셉")
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
                ForEach(finalKeyword.indices, id: \.self) { index in
                    let keyword = finalKeyword[index]
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
                            
                            Text("\(index+2)")
                                .font(.custom("SFProRounded-Semibold", size: 13))
                                .foregroundStyle(.main)
                        }
                        .padding(.leading, 35)
                        .padding(.trailing, 8)
                        
                        // 키워드
                        Text("\(keyword)")
                            .font(.finalTextList)
                        
                        
                        Spacer()
                        
                        // 옆면, 윗co면 뱃지
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: 29, height: 18)
                                .foregroundStyle(isSide ? .round : .top)
                            
                            Text("\(isSide ? "옆면" : "윗면")")
                                .font(.badgeText)
                                .foregroundStyle(isSide ? .main : .bg)
                        }
                        .padding(.trailing ,24)
                    }
                }
            }
        }
        .onAppear {
            fetchKeywords()
        }
    }
    
    func fetchKeywords() {
        let coreDataManager = CoredataManager.shared
        let orders = coreDataManager.getAllOrders()
        var keywords: [String] = []
        
        if let order = orders.last {
                for element in order.cakeElement {
                    keywords.append(element.elementKeyword)
                }
                
                if let firstElement = order.cakeElement.first {
                    isSide = firstElement.cakeDirection == .side
                }
            }
        
        finalKeyword = keywords
    }
}



//#Preview {
//    ZStack {
//        Color.bg
//
//        FinalListComponent()
//    } .ignoresSafeArea()
//}
