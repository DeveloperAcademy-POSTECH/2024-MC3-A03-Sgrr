
//
//  HomeView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var router: Router
    let coredataManager = CoredataManager.shared
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            
            ZStack {
                Color(.bg)
                Image("homeViewBG")
                    .frame(width: 393, height: 852)
                
                VStack {
                    HStack {
                        VStack (alignment: .leading) {
                            
                            Text("나만의 특별한")
                                .font(.koreanLargeTitle)
                            Text("Cakey")
                                .font(.englishLargeTitle)
                            
                        }
                        Spacer()
                    }
                    .padding(.leading, 17)
                    .padding(.top, 106)
                    .foregroundStyle(.main)
                    
                    Spacer()
                    
                    Button {
                        router.push(view: .OrderFormView)
                        
                    } label: {
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.main)
                                .frame(width: 345, height: 50)
                                .overlay() {
                                    Text("주문서 작성하기")
                                        .font(.completeText)
                                        .foregroundStyle(.white)
                                }
                                .padding(.bottom, 56)
                                .navigationDestination(for: Router.CakeyViews.self) { view in router.view(for: view)}
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .environmentObject(router)
            
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Router())
}
