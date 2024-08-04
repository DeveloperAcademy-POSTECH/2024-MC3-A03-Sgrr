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
    var colorBG: String = ""
    var colorLetter: String = ""
    var conceptKey: String = ""
    var conceptImg: Data = Data()
    var elementKey: [String] = []
    var elementImg: [Data] = []
}
