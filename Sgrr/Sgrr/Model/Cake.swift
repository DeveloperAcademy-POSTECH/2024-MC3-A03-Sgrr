//
//  Cake.swift
//  Sgrr
//
//  Created by Lee Wonsun on 7/31/24.
//

import Foundation
import Observation


@Observable
class Cake {
    var uuid = UUID()
    var colorBG: String
    var colorLetter: String
//    var conceptKey: String = ""
//    var conceptImg: Data = Data()
    
//    var elementKey: [String] = []
//    var elementImg: [Data] = []
    
    var concept: CakeElement
    
    var cakeTopList: [CakeElement]
    var cakeSideList: [CakeElement]
    
    init(uuid: UUID = UUID(), colorBG: String, colorLetter: String, concept: CakeElement, cakeTopList: [CakeElement], cakeSideList: [CakeElement]) {
        self.uuid = uuid
        self.colorBG = colorBG
        self.colorLetter = colorLetter
        self.concept = concept
        self.cakeTopList = cakeTopList // [CakeElement]
        self.cakeSideList = cakeSideList // [CakeElement]
    }
}

class CakeElement {
    var elementKeyword: String
    var elementImage: Data
    
    init(elementKeyword: String, elementImage: Data) {
        self.elementKeyword = elementKeyword
        self.elementImage = elementImage
    }
}
