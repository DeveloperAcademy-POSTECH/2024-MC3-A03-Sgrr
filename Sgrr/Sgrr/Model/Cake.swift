//
//  Cake.swift
//  Sgrr
//
//  Created by Lee Wonsun on 7/31/24.
//

import Foundation
import UIKit


struct Cake {
    var id: UUID
    var colorBG: String
    var colorLetter: String
    var conceptKey: String
    var conceptImg: Data
    var cakeElement: [CakeElement]
}

struct CakeElement: Identifiable {
    var id: UUID
    var elementImage: Data?
    var elementKeyword: String
    var photoPickerImage: UIImage?
    var cakeDirection: CakeDirection
}

enum CakeDirection {
    case top
    case side
}


