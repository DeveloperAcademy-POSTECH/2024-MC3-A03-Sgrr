//
//  FinalGuideView.swift
//  Sgrr
//
//  Created by Lee Wonsun on 8/1/24.
//

import SwiftUI

struct FinalGuideView: View {
//    @EnvironmentObject var router: Router<NavigationPath>
    @EnvironmentObject var router: Router

    var body: some View {
//        NavigationStack {
            ZStack {
                Color.bg
                
                // 홈버튼
                Button(action: {
//                    router.popToRoot()
                    router.backToHome()
                }, label: {
                    Image(systemName: "circle.fill")
                })
  
                guideTitle()
                
            } .ignoresSafeArea()
//        }
    }
    
    // MARK: - 디자인가이드 타이틀
    @ViewBuilder
    func guideTitle() -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Cakey")
                Text("Design Guide")
                Spacer()
            }
            .padding(.top, 18)
            .font(.englishLargeTitle)
            .foregroundStyle(.main)
            
            Spacer()
        } .padding(.leading, 16)
    }
}

#Preview {
    FinalGuideView()
}
