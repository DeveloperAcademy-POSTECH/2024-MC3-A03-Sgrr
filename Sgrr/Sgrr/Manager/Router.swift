//
//  Router.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//


import Foundation
import SwiftUI

class Router: ObservableObject{
    @Published var path: NavigationPath = NavigationPath()
    
    enum CakeyViews: Hashable{
        case HomeView
        case OrderFormView
        case Cake3DView
        case FinalGuideView
    }
    
    @ViewBuilder func view(for route: CakeyViews) -> some View {
        switch route{
        case .HomeView:
          HomeView()
        case .OrderFormView:
            OrderFormView()
        case .Cake3DView:
//            CakeView()
            OrderFormView()
        case .FinalGuideView:
            FinalGuideView()
        }
    }
    
    func push(view: CakeyViews){
        path.append(view)
    }
    
    func pop(){
        path.removeLast()
    }
    
    func backToHome(){
        self.path = NavigationPath()
    }
}
