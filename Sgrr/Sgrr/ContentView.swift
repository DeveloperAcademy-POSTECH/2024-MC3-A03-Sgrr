//
//  ContentView.swift
//  Sgrr
//
//  Created by dora on 7/25/24.
//

import SwiftUI
import CoreData
import Observation

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @State private var cakeData = CoredataManager.shared.cake
    
    @FetchRequest(
        entity: OrderForm.entity(),
        sortDescriptors: [] // 정렬 기준 없이 모든 데이터를 가져옴
    ) private var orderForms: FetchedResults<OrderForm>
    
    @State private var orderForm: OrderForm?
    
    var body: some View {
        VStack {
            TextField("Background Color", text: $cakeData.colorBG)
            TextField("Lettering Color", text: $cakeData.colorLetter)
            TextField("Concept Keyword", text: $cakeData.conceptKey)
            
                Button(action: {
                    saveOrder()
                }, label: {
                    Text("Save")
                })
            
            List {
                ForEach(orderForms) { order in
                    VStack(alignment: .leading) {
                        Text(order.conceptKeyword ?? "")
                            .font(.headline)
                        Text(order.colorBackground ?? "")
                        Text(order.colorLettering ?? "")
                    }
                    
                    Button(action: {
                        orderForm = order
                        deleteOrder()
                    }, label: {
                        Text("Delete")
                    })
                }
            }
        }
    }
    
    // MARK: - 저장함수
    private func saveOrder() {
        CoredataManager.shared.saveOrUpdateOrder()
    }
    
    private func deleteOrder() {
        if let orderForm = orderForm {
            CoredataManager.shared.deleteOrder(orderForm: orderForm)
        }
    }
}


#Preview {
    ContentView()
}
