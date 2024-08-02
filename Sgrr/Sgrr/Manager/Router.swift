//
//  Router.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import Foundation

final class Router<T: Hashable>: ObservableObject {
    @Published var paths: [T] = [] // 경로를 닮고 있는 paths
    
    // 앞뒤 경로 추가
    func push(_ path: T) {
        paths.append(path)
    }
    
    // 어디로 갈지
    func pop(to: T) {
        guard let found = paths.firstIndex(where: {$0 == to }) else {
            
            return
        }
        
        print(found)
        let numToPop = (found..<paths.endIndex).count - 1
        paths.removeLast(numToPop)
        
        
       
    }
    
    // 홈으로 돌아가기
    func popToRoot() {
        paths.removeAll()
    }
    
    
    
}


enum NavigationPath {
    case HomeView
    case OrderFormView
    case Cake3DView
    case FinalGuideView
}
