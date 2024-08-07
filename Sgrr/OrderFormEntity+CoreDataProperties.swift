//
//  OrderFormEntity+CoreDataProperties.swift
//  Sgrr
//
//  Created by Lee Wonsun on 8/7/24.
//
//

import Foundation
import CoreData


extension OrderFormEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderFormEntity> {
        return NSFetchRequest<OrderFormEntity>(entityName: "OrderFormEntity")
    }

    @NSManaged public var colorBackground: String?
    @NSManaged public var colorLettering: String?
    @NSManaged public var conceptImage: Data?
    @NSManaged public var conceptKeyword: String?
    @NSManaged public var uuid: UUID?
    @NSManaged public var cakeElements: NSSet?

}

// MARK: Generated accessors for cakeElements
extension OrderFormEntity {

    @objc(addCakeElementsObject:)
    @NSManaged public func addToCakeElements(_ value: CakeElementEntity)

    @objc(removeCakeElementsObject:)
    @NSManaged public func removeFromCakeElements(_ value: CakeElementEntity)

    @objc(addCakeElements:)
    @NSManaged public func addToCakeElements(_ values: NSSet)

    @objc(removeCakeElements:)
    @NSManaged public func removeFromCakeElements(_ values: NSSet)

}

extension OrderFormEntity : Identifiable {

}
