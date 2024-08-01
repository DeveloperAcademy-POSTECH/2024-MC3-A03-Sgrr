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
                .background(Color(hex: "FFFCF1"))
                
                Button {
                    // 작성 완료하기
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
        .toolbarBackground(Color.green, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                   Image(systemName: "plus")
                        .foregroundColor(.white)
                }
            }
        }
       
    }
}


#Preview {
    OrderFormView()
}
