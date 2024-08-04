//
//  OrderFormView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/26/24.
//

import SwiftUI

struct OrderFormView: View {
    @EnvironmentObject var router: Router<NavigationPath>

    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                ScrollView {
                    LazyVStack {
                        VStack {
                            ColorView()
                        } .frame(height: geo.size.height)
                        VStack {
                            ConceptView()
                        } .frame(height: geo.size.height)
                        VStack {
                            ComponentView()
                        } .frame(height: geo.size.height)
                    }
                    
                }
                .scrollTargetBehavior(.paging)
                .background(Color(hex: "F9F6EB"))
                
                Button {
                    // 작성 완료하기
//                    router.pop(to: .FinalGuideView)
                   router.push(.FinalGuideView)
                    //router.pop(to: .FinalGuideView)
                    
//                    [home, order, 3D, final]
//                    [order, 3d]
//                    [3d, order]
                    
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(hex: "FA5738"))
                        .frame(width: 345, height: 50)
                        .overlay() {
                            Text("작성 완료")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                }
                .padding(.top, 680)
            }
        }
        .toolbarBackground(Color(hex: "F9F6EB"), for: .navigationBar)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                
                
                Button {
                     //홈으로가기
                    router.popToRoot()
                } label: {
                 Image(systemName: "chevron.backward")
                        .foregroundColor(Color(hex: "FA5738"))
                        .font(.system(size: 20))
                }
               
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // 3D 뷰 이동
                    router.push(.Cake3DView)
                } label: {
                 Text("3D")
                        .foregroundColor(Color(hex: "FA5738"))
                        .font(.system(size: 20))
                }
               
            }
            
        }
        .navigationBarBackButtonHidden(true)
       
    }
}


#Preview {
    OrderFormView()
}
