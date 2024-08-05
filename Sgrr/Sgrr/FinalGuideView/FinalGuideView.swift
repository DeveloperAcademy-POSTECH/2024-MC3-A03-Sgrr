//
//  FinalGuideView.swift
//  Sgrr
//
//  Created by Lee Wonsun on 8/1/24.
//

import SwiftUI

struct FinalGuideView: View {
    @EnvironmentObject var router: Router
    @Environment(\.presentationMode) var presentationMode
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
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
    
    var combinedData: [Data] {
        var images: [Data] = orderForm.elementImage ?? []
        if let conceptImage = orderForm.conceptImage {
            images.insert(conceptImage, at: 0)
        }
        return images
    }
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                ZStack {
                    Color.bg
                        .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        guideTitle()
                            .padding(.bottom, 20)
                            .padding(.top, -20)
                        
                        // 이미지 6개 컴포넌트
                        imageVGrid()
                            .padding(.horizontal, 16)
                            .padding(.bottom, 24)
                        
                        FinalColorComponent(selectedBg: orderForm.colorBackground ?? "", selectedLetter: orderForm.colorLettering ?? "")
                            .padding(.bottom, 22)
                        
                        FinalListComponent(listNum: 1, keyword: orderForm.conceptKeyword ?? "", isElement: false)
                            .padding(.bottom, 22)
                        
                        FinalListComponent(orderMenu: "요소", listNum: 5)
                        
                        Spacer()
                        
                    } .padding(.bottom, -11)
                    
                }
            }
            .background(Color.bg)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 5) {
                        Menu {
                            Button(action: {
                                // 이미지 저장 액션
                            }) {
                                Text("이미지 저장")
                                Image(systemName: "square.and.arrow.down")
                            }
                            
                            Button(action: {
                                // 공유 액션
                            }) {
                                Text("공유")
                                Image(systemName: "square.and.arrow.up")
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .foregroundStyle(.main)
                        }
                        
                        Button(action: {
                            router.backToHome()
                        }, label: {
                            Image(systemName: "square.and.pencil")
                                .foregroundStyle(.main)
                        }) .padding(.bottom, 3.5)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.main)
                        }
                    }
                }
            }
        
    }
    
    // MARK: - 디자인가이드 타이틀
    @ViewBuilder
    func guideTitle() -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Cakey")
                    .font(.englishLargeTitle)
                    .padding(.bottom, 1)
                Text("케이크 가이드")
                    .font(.koreanLargeTitle)
            }
            .padding(.top, 18)
            .foregroundStyle(.main)
            
            Spacer()
        } .padding(.leading, 16)
    }
    
    // MARK: - 이미지 6개 컴포넌트
    @ViewBuilder
    func imageVGrid() -> some View {
        HStack {
            LazyVGrid(columns: columns) {
                ForEach(combinedData.indices, id: \.self) { index in
                    GuideImageComponent(num: index + 1, selectedImage: combinedData[index])
                }
            }
        }
    }
}

//#Preview {
//    FinalGuideView()
//}
