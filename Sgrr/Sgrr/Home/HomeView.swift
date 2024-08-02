
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
          
            ZStack {
                Color(hex: "FFF9E1")
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
                            case .HomeView:
                                HomeView()
                            case .OrderFormView: OrderFormView()
                            case .Cake3DView:
                                testView()
                            case .FinalGuideView: FinalGuideView()
                                
                            }
                        }
                    }
                    
                }
                .padding(.trailing, 150)
                .foregroundColor(Color(hex: "FA5738"))
            }
            .ignoresSafeArea()
           
        
               
        }
       
        .environmentObject(router)
        
       
       
    }
}

#Preview {
    HomeView()
}
