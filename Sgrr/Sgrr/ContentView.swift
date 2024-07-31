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
    @State private var cakeData = CoredataManager.shared.cake
    @FetchRequest(
        entity: OrderForm.entity(),
        sortDescriptors: [] // 정렬 기준 없이 모든 데이터를 가져옴
    ) private var orderForms: FetchedResults<OrderForm>

    var body: some View {
        ZStack {
            Text("\(cakeData.colorBG)") // 사용 예시
        }
    }
    
    // MARK: - 저장 함수
    private func save() {
        CoredataManager.shared.saveOrUpdateOrder()
    }
}


#Preview {
    ContentView()
}
