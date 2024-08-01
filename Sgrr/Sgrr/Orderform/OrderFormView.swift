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
                    
                } label: {
                 Image(systemName: "chevron.backward")
                        .foregroundColor(Color(hex: "FA5738"))
                        .font(.system(size: 20))
                }
               
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
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
