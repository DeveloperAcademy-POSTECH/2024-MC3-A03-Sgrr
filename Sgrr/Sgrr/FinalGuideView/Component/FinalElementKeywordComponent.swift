//
//  FinalKeywordListComponent.swift
//  Sgrr
//
//  Created by Lee Wonsun on 8/4/24.
//

import SwiftUI

struct FinalElementKeywordComponent: View {
    @FetchRequest(
        entity: OrderForm.entity(),
        sortDescriptors: [] // 정렬 기준 없이 모든 데이터를 가져옴
    ) private var orderForms: FetchedResults<OrderForm>
    
    var orderForm: OrderForm {
        guard let order = orderForms.last else {
            return OrderForm()
        }
        return order
    }
    
    @State var orderMenu: String = "컨셉"
    @State var place: String = "옆면"
    @State var isElement: Bool = true
    var startFromSecond: Bool = false

    
    var combineKeyword: [String] {
        var keywords: [String] = orderForm.elementTopKeyword ?? []
        if let conceptKeyword = orderForm.conceptKeyword {
            keywords.insert(conceptKeyword, at: 0)
        }
        
        if isElement && startFromSecond && keywords.count >= 1 {
                    keywords.removeFirst()
                }
        
        return keywords
    }
    
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
                ForEach(Array(combineKeyword.enumerated()), id: \.element) { (index, keyword) in
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
                            
                            Text("\(isElement ? index+2 : index+1)")
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

//#Preview {
//    ZStack {
//        Color.bg
//        
//        FinalListComponent()
//    } .ignoresSafeArea()
//}
