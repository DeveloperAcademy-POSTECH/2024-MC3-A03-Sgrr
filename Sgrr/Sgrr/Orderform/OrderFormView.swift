//
//  OrderFormView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/26/24.
//

import SwiftUI

struct OrderFormView: View {
    @EnvironmentObject var router: Router
    private var cakeData = CoredataManager.shared

    
    @FetchRequest(
        entity: OrderForm.entity(),
        sortDescriptors: [] // 정렬 기준 없이 모든 데이터를 가져옴
    ) private var orderForms: FetchedResults<OrderForm>

    var body: some View {
        
        GeometryReader { geo in
            let safeAreaTopHeight = geo.safeAreaInsets.top
            let safeAreaHeight = geo.safeAreaInsets.bottom
            
            ZStack(alignment: .bottom) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ColorCell()
                            .ignoresSafeArea(edges: .bottom)
                            .frame(height: geo.size.height + safeAreaHeight)
                        
                        ConceptView()
                            .ignoresSafeArea(edges: .bottom)
                            .frame(height: geo.size.height + safeAreaHeight)
                        
                        ComponentView()
                            .ignoresSafeArea(edges: .bottom)
                            .frame(height: geo.size.height + safeAreaHeight)
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.paging)
                .ignoresSafeArea(edges: .bottom)
                .foregroundStyle(.background)
                .background(Color.bg)
                
                Button {
                    // 작성 완료하기
//                    router.push(view: .FinalGuideView)
                    
                    
                    // 타이니 수정 ver
                    
                    if let orderForm = orderForms.last {
                        router.push(view: .FinalGuideView)
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.main)
                        .frame(width: 345, height: 50)
                        .overlay() {
                            Text("작성 완료")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                }
            }
        }
        .toolbarBackground(Color(hex: "F9F6EB"), for: .navigationBar)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                
                Button {
                     // 홈으로 가기
                    router.backToHome()
                } label: {
                 Image(systemName: "chevron.backward")
                        .foregroundStyle(.main)
                        .font(.system(size: 20))
                }
               
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // 3D 뷰 이동
                    router.push(view: .Cake3DView)
                } label: {
                 Text("3D")
                        .foregroundStyle(.main)
                        .font(.system(size: 20))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
       
    }
}

// MARK: - 저장함수
private func saveOrder() {
    CoredataManager.shared.saveOrUpdateOrder()
}


#Preview {
    OrderFormView()
}

