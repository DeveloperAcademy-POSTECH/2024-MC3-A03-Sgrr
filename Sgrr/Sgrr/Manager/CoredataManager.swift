//
//  CoredataManager.swift
//  Sgrr
//
//  Created by Lee Wonsun on 7/29/24.
//

import Foundation
import CoreData

class CoredataManager {
    static var shared: CoredataManager = CoredataManager()
    private init () {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Sgrr")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return container
    } ()
    
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

extension CoredataManager {
    // MARK: - 저장, 업데이트
    func saveOrUpdateOrder(colorBG: String, colorLetter: String, conceptKey: String, conceptImg: String, elementKey: [String], elementImg: [String]) {
        let fetchRequest: NSFetchRequest<OrderForm> = OrderForm.fetchRequest()
        
        do {
            let orderResult = try context.fetch(fetchRequest)
            let orderForm: OrderForm
            
            if let existingOrder = orderResult.first {
                orderForm = existingOrder
            } else {
                orderForm = OrderForm(context: context)
                orderForm.uuid = UUID()
            }
            
            orderForm.colorBackground = colorBG
            orderForm.colorLettering = colorLetter
            orderForm.conceptKeyword = conceptKey
            orderForm.conceptImage = conceptImg
            orderForm.elementKeyword = elementKey
            orderForm.elementImage = elementImg
            
            try context.save()
            
        } catch {
            print("오류 타입: \(error.localizedDescription)")
            fatalError("Failed to save context, \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - 삭제
    func deleteOrder(orderForm: OrderForm) {
        do {
            context.delete(orderForm)
            try context.save()
        } catch {
            print("오류 타입: \(error.localizedDescription)")
            fatalError("Failed to delete context, \(error.localizedDescription)")
        }
    }
}
