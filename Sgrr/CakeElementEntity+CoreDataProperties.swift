//
//  CakeElementEntity+CoreDataProperties.swift
//  Sgrr
//
//  Created by Lee Wonsun on 8/8/24.
//
//

import Foundation
import CoreData


extension CakeElementEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CakeElementEntity> {
        return NSFetchRequest<CakeElementEntity>(entityName: "CakeElementEntity")
    }

    @NSManaged public var isSide: Bool
    @NSManaged public var elementImages: Data?
    @NSManaged public var elementKeywords: String?

}

extension CakeElementEntity : Identifiable {

}
