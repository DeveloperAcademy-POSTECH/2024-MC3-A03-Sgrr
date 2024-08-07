////
////  FinalKeywordListComponent.swift
////  Sgrr
////
////  Created by Lee Wonsun on 8/4/24.
////
//
//import SwiftUI
//
//struct FinalElementKeywordComponent: View {
//
//    
//    
////    var topKeyword: [String] {
////        if let keyword = orderForm.elementTopKeyword {
////            return keyword
////        }
////        return []
////    }
////    
////    var sideKeyword: [String] {
////        if let keyword = orderForm.elementSideKeyword {
////            return keyword
////        }
////        return []
////    }
//    
//    
////    var combineKeyword: [String: [String]] {
////        var keywords: [String : [String]] = [:]
////        let topKeywords: [String : [String]] = ["윗면" : orderForm.elementTopKeyword ?? []]
////        let sideKeywords: [String : [String]] = ["옆면" : orderForm.elementSideKeyword ?? []]
////
////
////        return keywords
////    }
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            // MARK: - 컨셉, divider
//            VStack(alignment: .leading, spacing: 0) {
//                Text("요소")
//                    .font(.finalFormTitle)
//                    .foregroundStyle(.main)
//                    .padding(.bottom, 5)
//                    .padding(.leading, 10)
//                
//                Rectangle()
//                    .frame(width: 361, height: 2)
//                    .foregroundStyle(.main)
//            }
//            .padding(.bottom, 10)
//            
//            // MARK: - 리스트 내용
//            VStack(spacing: 11) {
//                ForEach(Array(topKeyword.enumerated()), id: \.element) { (index, keyword) in
//                    HStack(spacing: 0) {
//                        // 숫자 넘버
//                        ZStack(alignment: .center) {
//                            Circle()
//                                .frame(width: 18)
//                                .foregroundStyle(.clear)
//                                .overlay (
//                                    Circle()
//                                        .stroke(Color(.main), lineWidth: 2)
//                                        .frame(width: 18))
//
//                            Text("\(index+2)")
//                                .font(.custom("SFProRounded-Semibold", size: 13))
//                                .foregroundStyle(.main)
//                        }
//                        .padding(.leading, 35)
//                        .padding(.trailing, 8)
//
//                        // 키워드
//                        Text("\(keyword)")
//                            .font(.finalTextList)
//
//
//                        Spacer()
//
//                        // 옆면, 윗면 뱃지
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 6)
//                                .frame(width: 29, height: 18)
//                                .foregroundStyle(.top)
//
//                            Text("앞면")
//                                .font(.badgeText)
//                                .foregroundStyle(.bg)
//                        }
//                        .padding(.trailing ,24)
//                    }
//                }
//                
//                ForEach(Array(sideKeyword.enumerated()), id: \.element) { (index, keyword) in
//                    HStack(spacing: 0) {
//                        // 숫자 넘버
//                        ZStack(alignment: .center) {
//                            Circle()
//                                .frame(width: 18)
//                                .foregroundStyle(.clear)
//                                .overlay (
//                                    Circle()
//                                        .stroke(Color(.main), lineWidth: 2)
//                                        .frame(width: 18))
//
//                            Text("\(index+2+topKeyword.count)")
//                                .font(.custom("SFProRounded-Semibold", size: 13))
//                                .foregroundStyle(.main)
//                        }
//                        .padding(.leading, 35)
//                        .padding(.trailing, 8)
//
//                        // 키워드
//                        Text("\(keyword)")
//                            .font(.finalTextList)
//
//
//                        Spacer()
//
//                        // 옆면, 윗면 뱃지
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 6)
//                                .frame(width: 29, height: 18)
//                                .foregroundStyle(.round)
//
//                            Text("옆면")
//                                .font(.badgeText)
//                                .foregroundStyle(.main)
//                        }
//                        .padding(.trailing ,24)
//                    }
//                }
//            }
//        }
//    }
//}
//
////#Preview {
////    ZStack {
////        Color.bg
////
////        FinalListComponent()
////    } .ignoresSafeArea()
////}
