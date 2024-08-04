//
//  ComponentView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI
import Combine

struct ComponentView: View {
    private var cakeData = CoredataManager.shared

    @State var cakeTopItems: [Int] = []
    @State var cakeSideItems: [Int] = []
    @State var cakeTopKeyword: [String] = []
    @State var cakeSideKeyword: [String] = []
    
    @State var elementKeyword: String = "" //요소
    private let characterLimit: Int = 15     //최대 글자 수 제한
    @FocusState private var isFocused: Bool

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
                            // 텍스트필드
                            ZStack {
                                VStack {
                                    HStack {
                                        //사용자 입력을 받는 텍스트 필드
                                        TextField("텍스트를 입력하세요", text: $elementKeyword)
                                            .foregroundColor(.black)
                                        // 텍스트 값이 변경될 때마다 글자 수 제한 함수 호출
                                            .onReceive(Just(elementKeyword)) { newValue in
                                                limitText(newValue, upper: characterLimit)
                                            }
                                            .onChange(of: elementKeyword) {
                                                cakeData.cake.elementKey = elementKeyword
                                                saveOrder()
                                            }
                                        
                                        // 자동 수정 설정 해제
                                            .disableAutocorrection(false)
                                            .focused($isFocused)
                                    }
                                    .padding()
                                    
                                }
                                // clear Button 구현
                                .onAppear {
                                    UITextField.appearance().clearButtonMode = .whileEditing
                                }
                            }
                       
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
                          // 텍스트 필드
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
    
    private func limitText(_ newValue: String, upper: Int) {
        if newValue.count > upper {
            elementKeyword = String(newValue.prefix(upper))
        }
    }
}

// MARK: - 저장함수
private func saveOrder() {
    CoredataManager.shared.saveOrUpdateOrder()
}



#Preview {
    ComponentView()
}
