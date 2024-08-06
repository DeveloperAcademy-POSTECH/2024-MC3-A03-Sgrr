//
//  ComponentView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI
import Combine
import PhotosUI

struct ComponentView: View {
    private var cakeData = CoredataManager.shared
    
    // 이미지
    @State private var elementImage: UIImage?
    @State private var photosPickerComponentItem: PhotosPickerItem?
    
    @State var cakeTopItems: [Int] = []
    @State var cakeSideItems: [Int] = []
   
    // 키워드
    @State var cakeTopKeyword: String = "" 
    // 각각의 텍스트 필드 만들기 -> array의 string 타입으로
    // + 될 때 마다 어떤 형태로 만들어야 개수에 상관없이 textfield에 대응할 수 있을까
    
    @State var cakeTopKeywordList: [String] = []
    @State var cakeSideKeyword: String = ""
    @State var cakeSideKeywordList: [String] = []
    
    @State var elementKeyword: String = "" //textfield 요소
    

    
    private let characterLimit: Int = 15     //최대 글자 수 제한
    @FocusState private var isFocused: Bool


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
//                            ImageAddView(text: "ㅁㄴㅇㄹ")
                            
                            // 텍스트필드
                            ZStack {
                                VStack {
                                    HStack {
                                        //사용자 입력을 받는 텍스트 필드
                                        TextField("텍스트를 입력하세요", text: $cakeTopKeyword)
                                            .foregroundColor(.black)
                                        // 텍스트 값이 변경될 때마다 글자 수 제한 함수 호출
                                            .onReceive(Just(cakeTopKeyword)) { newValue in
                                                limitText(newValue, upper: characterLimit)
                                            }
                                            .onChange(of: cakeTopKeyword) {
                                                // cakeTopKeyword를 list에 넣기
                                                // 할당을 새로 시킨다
                                                
//                                                cakeData.cake.elementKey = cakeTopKeyword
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
//                            ImageAddView()
                          // 텍스트 필드
//                            TextFieldView()
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
            .background(Color.clear)
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
            cakeTopKeyword = String(newValue.prefix(upper))
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
