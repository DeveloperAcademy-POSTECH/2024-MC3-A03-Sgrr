//
//  Extension+Font.swift
//  Sgrr
//
//  Created by Lee Wonsun on 8/1/24.
//

import Foundation
import SwiftUI

extension Font {
    // MARK: - 폰트종류 등록
    static func pilGiFont(size: CGFloat) -> Font {
        return Font.custom("JCfg", size: size)
    }
    
    static func gMarketFont(size: CGFloat) -> Font {
        return Font.custom("GmarketSansMedium", size: size)
    }
    
    static func sfProDisplayMediumFont(size: CGFloat) -> Font {
        return Font.custom("SFProDisplay-Medium", size: size)
    }
    
    static func sfProDisplayRegularFont(size: CGFloat) -> Font {
        return Font.custom("SFProDisplay-Regular", size: size)
    }
    
    static func sfProDisplaySemiboldFont(size: CGFloat) -> Font {
        return Font.custom("SFProDisplay-Semibold", size: size)
    }
    
    static func sfProDisplayBoldFont(size: CGFloat) -> Font {
        return Font.custom("SFProDisplay-Bold", size: size)
    }
    
    static func sfProRoundedSemiboldFont(size: CGFloat) -> Font {
        return Font.custom("SFProRounded-Semibold", size: size)
    }
    
    // MARK: - HomeView, FinalGuideView 타이틀명
    static var englishLargeTitle: Font {
        return pilGiFont(size: 48)
    }
    
    static var koreanLargeTitle: Font {
        return gMarketFont(size: 32)
    }
    
    // MARK: - OrderFormView
    static var orderFormTitle: Font {
        return sfProDisplayBoldFont(size: 32)
    }
    
    static var colorTitle: Font {
        return sfProDisplaySemiboldFont(size: 20)
    }
    
    static var hexText: Font {
        return sfProDisplayRegularFont(size: 17)
    }
    
    static var elementAddTitle: Font {
        return sfProDisplayRegularFont(size: 13)
    }
    
    static var elementListTitle: Font {
        return sfProDisplayRegularFont(size: 13)
    }
    
    static var saveText: Font {
        return sfProDisplayRegularFont(size: 14)
    }
    
    static var completeText: Font {
        return sfProDisplaySemiboldFont(size: 17)
    }
    
    // MARK: - FinalGuideView
    static var finalFormTitle: Font {
        return sfProDisplayBoldFont(size: 17)
    }
    
    static var finalHexText: Font {
        return sfProDisplayRegularFont(size: 12)
    }
    
    static var finalTextList: Font {
        return sfProDisplayMediumFont(size: 17)
    }
    
    static var finalNumber: Font {
        return sfProRoundedSemiboldFont(size: 12)
    }
    
    static var badgeText: Font {
        return sfProDisplayRegularFont(size: 10)
    }
}
