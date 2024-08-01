//
//  HomeView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var router = Router<NavigationPath>()
    
    var body: some View {
        
        NavigationStack(path: $router.paths) {
            VStack(alignment: .leading) {
                
                Text("나만의 특별한")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .padding(.top, 50)
                Text("Cakey")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    
                
                Button {
                    router.push(.OrderFormView)
                    
                } label: {
                    HStack {
                        Text("작성하러 가기")
                        Image(systemName: "chevron.right")
                    }
                        .padding(.top, 10)
                    
                    .navigationDestination(for: NavigationPath.self) { path in
                        switch path {
                        case .HomeView: HomeView()
                        case .OrderFormView: OrderFormView()
                        case .Cake3DView: Cake3DView()
                        }
                    }
                }
                
            }
            .padding(.trailing, 150)
            .foregroundColor(Color(hex: "FA5738"))
            Spacer()
            
            ZStack {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(hex: "FA5738"))
                        .frame(height: 473)
                    Text("색상")
                }
                   
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(hex: "FA8C76"))
                        .frame(height: 373)
                        .padding(.top, 100)
                    Text("컨셉")
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(hex: "FAC0B5"))
                        .frame(height: 273)
                        .padding(.top, 200)
                    HStack {
                        Text("요소")
                            .foregroundColor(Color(hex: "FFFCF1"))
                        Spacer()
                    }
                }
                
            }
        }
        .environmentObject(router)
        
       
       
    }
}

#Preview {
    HomeView()
}
