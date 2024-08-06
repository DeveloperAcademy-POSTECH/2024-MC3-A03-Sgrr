//
//  FinalConceptKeywordComponent.swift
//  Sgrr
//
//  Created by Lee Wonsun on 8/6/24.
//

import SwiftUI

struct FinalConceptKeywordComponent: View {
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
                            
                            Text("1")
                                .font(.custom("SFProRounded-Semibold", size: 13))
                                .foregroundStyle(.main)
                        }
                        .padding(.leading, 35)
                        .padding(.trailing, 8)
                        
                        // 키워드
                        if let conceptKeyword = orderForm.conceptKeyword {
                            Text(conceptKeyword)
                                .font(.finalTextList)
                        }

                        Spacer()
                    }
                
            }
        }
    }
}

//#Preview {
//    ZStack {
//        Color.bg
//
//        FinalConceptKeywordComponent()
//    } .ignoresSafeArea()
//}
