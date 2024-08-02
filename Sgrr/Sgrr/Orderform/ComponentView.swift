//
//  ComponentView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI

struct ComponentView: View {
    @State var cakeTopItems: [Int] = []
    @State var cakeSideItems: [Int] = []
    // 상단에서 데이터 넣어주고
    // 바인딩해서 데이터를 받아야됨
    // 위 -> 아래 ,ㅓ
    

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
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
                        .foregroundColor(Color(hex: "FA5738"))
                    Spacer()
                    Button {
//                        addItem(in: &cakeTopItems)
                        cakeTopItems = addItem(to: cakeTopItems)
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color(hex: "FA5738"))
                    }
                    .disabled(totalItems >= 5)
                }) {
                    ForEach(cakeTopItems.indices, id: \.self) { index in
                        HStack {
                            ImageAddView()
                            TextFieldView()
                        }
                        
                    }
                   
                    .onDelete(perform: { deleteItem(at: $0, from: &cakeTopItems) })
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .listRowSeparator(.hidden)
                
                Section(header: HStack {
                    Text("케이크 옆면")
                        .foregroundColor(Color(hex: "FA5738"))
                    Spacer()
                    Button {
//                        addItem(in: &cakeSideItems)
                        cakeSideItems = addItem(to: cakeSideItems)
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color(hex: "FA5738"))
                    }
                    .disabled(totalItems >= 5)
                }) {
                    ForEach(cakeSideItems.indices, id: \.self) { index in
                        HStack {
                            ImageAddView()
                            TextFieldView()
                        }
                    }
                    .onDelete(perform: { deleteItem(at: $0, from: &cakeSideItems) })
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(SidebarListStyle())
            .listRowBackground(Color.clear)
//            .listRowInsets(EdgeInsets())
            .background(Color.yellow)
            .scrollContentBackground(.hidden)
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
    ComponentView()
}
