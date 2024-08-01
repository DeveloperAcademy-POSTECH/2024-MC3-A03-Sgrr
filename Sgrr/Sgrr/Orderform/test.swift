//
//  test.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 8/1/24.
//

import SwiftUI

struct test: View {
    @State private var cakeTopItems: [Int] = []
    @State private var cakeSideItems: [Int] = []

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .cornerRadius(10, corners: [.topLeft, .topRight])
                    .frame(width: 393, height: 95)
                    .foregroundColor(Color(hex: "FAC0B5"))
                Text("요소")
                    .foregroundColor(Color(hex: "FFFCF1"))
                    .font(.system(size: 34))
                    .fontWeight(.black)
                    .padding(.trailing, 280)
                    .padding(.top, 30)
            }
            
            List {
                Section(header: HStack {
                    Text("케이크 윗면")
                    Spacer()
                    Button {
//                        addItem(in: &cakeTopItems)
                        cakeTopItems = addItem(to: cakeTopItems)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .disabled(totalItems >= 5)
                }) {
                    ForEach(cakeTopItems.indices, id: \.self) { index in
                        ImageAddView()
                    }
                    .onDelete(perform: { deleteItem(at: $0, from: &cakeTopItems) })
                }
                .listRowSeparator(.hidden)
                
                Section(header: HStack {
                    Text("케이크 옆면")
                    Spacer()
                    Button {
//                        addItem(in: &cakeSideItems)
                        cakeSideItems = addItem(to: cakeSideItems)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .disabled(totalItems >= 5)
                }) {
                    ForEach(cakeSideItems.indices, id: \.self) { index in
                        ImageAddView()
                    }
                    .onDelete(perform: { deleteItem(at: $0, from: &cakeSideItems) })
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            .background(Color.clear)
            .scrollContentBackground(.hidden)
            
            Spacer()
        }
    }
    
    private var totalItems: Int {
        cakeTopItems.count + cakeSideItems.count
    }
    
//    private func addItem(in list: inout [Int]) {
//        guard totalItems < 5 else { return }
//        list.append(list.count)
//    }
    
    private func addItem(to list: [Int]) -> [Int] {
            guard list.count < 5 else { return list }
            var newList = list
            newList.append(newList.count)
            return newList
        }
    
    
    private func deleteItem(at offsets: IndexSet, from list: inout [Int]) {
        list.remove(atOffsets: offsets)
    }
}

#Preview {
    test()
}
