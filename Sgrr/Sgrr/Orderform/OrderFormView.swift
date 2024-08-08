//
//  OrderFormView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/26/24.
//

import SwiftUI
import CoreData

struct OrderFormView: View {
    @EnvironmentObject var router: Router
    
    let coredataManager = CoredataManager.shared
    
    // ColorCell
    @State var bgColorToString: String = ""
    @State var letteringColorToString: String = ""
    // ConceptView
    @State var conceptImageToData: Data = Data()
    @State var conceptBindingKeyword: String = ""
    // ElementView
    @State private var cakeElementList: [CakeElement] = [
        .init(id: UUID(), elementKeyword: "", cakeDirection: .top),
        .init(id: UUID(), elementKeyword: "", cakeDirection: .side)
    ]
    
    var body: some View {
        
        GeometryReader { geo in
            let safeAreaHeight = geo.safeAreaInsets.bottom
            
            ZStack(alignment: .bottom) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ColorCell(bgColorToString: $bgColorToString, letteringColorToString: $letteringColorToString)
                            .ignoresSafeArea(edges: .bottom)
                            .frame(height: geo.size.height + safeAreaHeight)
                        
                        ConceptView(conceptImageToData: $conceptImageToData, conceptBindingKeyword: $conceptBindingKeyword)
                            .ignoresSafeArea(edges: .bottom)
                            .frame(height: geo.size.height + safeAreaHeight)
                        
                        ElementView(cakeElementList: $cakeElementList)
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
                    let cake = Cake(id: UUID(), colorBG: bgColorToString, colorLetter: letteringColorToString, conceptKey: conceptBindingKeyword, conceptImg: conceptImageToData, cakeElement: cakeElementList)
                    coredataManager.createOrderFormEntity(cake: cake)
                    print("\(cake)")
                    router.push(view: .FinalGuideView)
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.main)
                        .frame(width: 345, height: 50)
                        .overlay() {
                            Text("작성 완료")
                                .foregroundColor(.white)
                                .font(.completeText)
                        }
                        .padding(.bottom, 20)
                        .shadow(color: Color(hex: "FA5738"), radius: 2, x: 0, y: 4)
                    
                    
                }
            }
        }
        .toolbarBackground(Color(.bg), for: .navigationBar)
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
                    let cake = Cake(id: UUID(), colorBG: bgColorToString, colorLetter: letteringColorToString, conceptKey: conceptBindingKeyword, conceptImg: conceptImageToData, cakeElement: cakeElementList)
                    coredataManager.createOrderFormEntity(cake: cake)
                    
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



//#Preview {
//    OrderFormView()
//}

