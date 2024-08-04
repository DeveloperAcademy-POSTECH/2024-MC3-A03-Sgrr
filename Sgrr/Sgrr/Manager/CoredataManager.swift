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
    var cake = Cake()
    private init () {
        self.cake = Cake()
    }
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Sgrr")
 
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
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
    func saveOrUpdateOrder() {
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
            
            orderForm.colorBackground = cake.colorBG
            orderForm.colorLettering = cake.colorLetter
            orderForm.conceptKeyword = cake.conceptKey
            orderForm.conceptImage = cake.conceptImg
            orderForm.elementKeyword = cake.elementKey
            orderForm.elementImage = cake.elementImg
            
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
