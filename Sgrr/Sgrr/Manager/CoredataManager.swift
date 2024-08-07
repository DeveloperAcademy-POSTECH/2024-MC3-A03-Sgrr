//
//  NewCoredataManager.swift
//  Sgrr
//
//  Created by Lee Wonsun on 8/7/24.
//

import Foundation
import CoreData

class CoredataManager {
    // 싱글톤 인스턴스 생성
    static let shared = CoredataManager()
    
    // NSPersistentContainer - 앱의 코어데이터 스택 캡슐화
    lazy var persistentContainer: NSPersistentContainer = {
        // 모델이름이 "Sgrr"인 NSPersistentContainer 생성
        let container = NSPersistentContainer(name: "Sgrr")
        
        // 영구저장소 로드, 오류 발생하면 앱 중지
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    } ()
    
    // context - 작업 수행하는 NSManagerObjectContext 반환
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    // 데이터베이스에 변경사항 저장하는 함수
    func save() {
        guard context.hasChanges else { return } // 변경사항이 없으면 함수 종료
        
        do {
            try context.save() // 변경사항 저장
            print("context에 데이터 저장")
        } catch {
            print("context에 저장 실패: ", error.localizedDescription) // 저장 실패 시 메시시 출력
        }
    }
    
    // 새로운 orderFormEntity 생성 함수 (Create)
    func createOrderFormEntity(cake: Cake) {
        let newOrderForm = OrderFormEntity(context: context) // 새로운 orderForm 엔티티 생성
        newOrderForm.uuid = UUID()
        newOrderForm.colorBackground = cake.colorBG
        newOrderForm.colorLettering = cake.colorLetter
        newOrderForm.conceptImage = cake.conceptImg
        newOrderForm.conceptKeyword = cake.conceptKey
        print("Create")
        
        // 각 orderForm에 대한 CakeElementEntity를 생성해 OrderFormEntity에 추가하기
        for cakeElement in cake.cakeElement {
            let newCakeElement = CakeElementEntity(context: context)
            newCakeElement.isSide = cakeElement.cakeDirection == .side
            newCakeElement.elementKeywords = cakeElement.elementKeyword
            newCakeElement.elementImages = cakeElement.elementImage
            newOrderForm.addToCakeElements(newCakeElement) // newCakeElement를 newOrderForm 관계에 추가하는 작업 (1:N 작업)
        }
        print("Create2")
        save()
    }
    
    // 특정 orderForm의 ID를 사용해 OrderFormEntity를 가져오는 함수
    func fetchEntityID(cake: Cake) -> OrderFormEntity? {
        let id = cake.id
        let request = OrderFormEntity.fetchRequest() // OrderFormEntity를 호출하는 요청 생성
        request.predicate = NSPredicate(format: "id==%@", id as CVarArg) // 특정 ID를 기준으로 필터링
        request.fetchLimit = 1 // 결과는 최대 1개로 제한
        
        do {
            let results = try context.fetch(request) // 요청을 실행하고 결과 가져오기
            return results.first // 첫번째 결과 반환
        } catch {
            print("id값 가져오기 실패: \(error.localizedDescription)") // 오류 발생 시 메시지 출력
            return nil
        }
    }
    
    func fetchAllOrderFormEntities() -> [OrderFormEntity] {
        do {
            let request = OrderFormEntity.fetchRequest() // OrderFormEntity 가져오는 요청 생성
//            request.fetchLimit = 1 // 하나의 결과만 가져오기
            let results = try context.fetch(request)
            return results
        } catch {
            print("불러오기 실패: \(error.localizedDescription)")
        }
        return []
    }
    
    func getAllOrders() -> [Cake] {
        var cakes: [Cake] = []
        let fetchResults = fetchAllOrderFormEntities()
        for entity in fetchResults {
            let uuid = entity.uuid
            let colorBackground = entity.colorBackground
            let colorLettering = entity.colorLettering
            let conceptKeyword = entity.conceptKeyword
            let conceptImage = entity.conceptImage
            
            var cakeElements: [CakeElement] = []
            
            if let cakeElementEntities = entity.cakeElements as? Set<CakeElementEntity> {
                for cakeElement in cakeElementEntities {
                    let cakeElement = CakeElement(id: UUID(), elementImage: cakeElement.elementImages, elementKeyword: cakeElement.elementKeywords ?? "", cakeDirection: cakeElement.isSide == true ? .side : .top)
                    cakeElements.append(cakeElement)
                }
            }
            let order = Cake(id: uuid ?? UUID(), colorBG: colorBackground ?? "", colorLetter: colorLettering ?? "", conceptKey: conceptKeyword ?? "", conceptImg: conceptImage ?? Data(), cakeElement: cakeElements)
            cakes.append(order)
        }
       return cakes
    }
    
    func deleteOrderFormEntity(cake: Cake) {
        if let entity = fetchEntityID(cake: cake) {
            context.delete(entity)
            save()
        }
    }
}
