//
//  test8.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 8/6/24.
//



import SwiftUI
import Combine
import PhotosUI

// 조니
struct test8: View {
    private var cakeData = CoredataManager.shared
    
    @State var text: String? = nil
    @State private var photosPickerConceptItem: PhotosPickerItem?
//    @State private var conceptImage: UIImage?

    
    // 이미지
//    @State var cakeTopItems: [Int] = [0]
//    @State var cakeSideItems: [Int] = [0]
   
    // 키워드
    @State var cakeTopKeywords: [String] = [""]
    @State var cakeSideKeywords: [String] = [""]

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
//                        addItem(to: &cakeTopItems, keywords: &cakeTopKeywords)
                        cakeData.cake.cakeTopList.append(CakeElement(elementKeyword: nil, elementImage: Data()))
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color(hex: "FA5738"))
                    }
                    .disabled(totalItems >= 5)
                }) {
                    ForEach(cakeData.cake.cakeTopList.indices, id: \.self) { index in
                        HStack {
//                            ImageAddView(text: $text)
                            
                            PhotosPicker(selection: $photosPickerConceptItem, matching: .images) {
                                ZStack {
                                    Rectangle()
                                        .frame(width: 62, height: 62)
                                        .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                                        .foregroundColor(.white)
                    //                    .border(width: 0.5, edges: [.trailing], color: Color(hex: "D9D9D9"))
                                    Image("ImageIcon")
                                        .resizable()
                                        .frame(width: 30, height: 24)
                                        .scaledToFit()
                                    
                                    if let conceptImage = cakeData.cake.cakeTopList[index].elementImage {
                                        Image(uiImage: conceptImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 62, height: 62)
                                            .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                                    }
                                }
                            }
                            .onChange(of: photosPickerConceptItem) { _, _ in
                                Task {
                                    if let photosPickerConceptItem,
                                       let data = try? await photosPickerConceptItem.loadTransferable(type: Data.self) {
                                        if let image = UIImage(data: data) {
                                            saveOrder()
                                        }
                                    }
                                   
                                }
                            }
                            
                            // 텍스트필드
                            ZStack {
                                VStack {
                                    HStack {
                                        //사용자 입력을 받는 텍스트 필드
                                        TextField("텍스트를 입력하세요", text: cakeData.cake.cakeTopList[index].elementKeyword)
                                            .foregroundColor(.black)
                                        // 텍스트 값이 변경될 때마다 글자 수 제한 함수 호출
                                            .onReceive(Just(cakeData.cake.cakeTopList[index])) { newValue in
                                                limitText(newValue, in: &cakeTopKeywords, at: index, upper: characterLimit)
                                            }
                                            .onChange(of: cakeTopKeywords[index]) {
                                                cakeData.cake.elementKey = cakeTopKeywords
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
                   
                    .onDelete(perform: { deleteItem(at: $0, from: &cakeTopItems, keywords: &cakeTopKeywords) })
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .listRowSeparator(.hidden)
                
                Section(header: HStack {
                    Text("케이크 옆면")
                        .foregroundColor(Color(hex: "FA5738"))
                    Spacer()
                    Button {
                        addItem(to: &cakeSideItems, keywords: &cakeSideKeywords)
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
                            TextField("텍스트를 입력하세요", text: $cakeSideKeywords[index])
                                .foregroundColor(.black)
                                .onReceive(Just(cakeSideKeywords[index])) { newValue in
                                    limitText(newValue, in: &cakeSideKeywords, at: index, upper: characterLimit)
                                }
                                .onChange(of: cakeSideKeywords[index]) {
                                    cakeData.cake.elementKey = cakeSideKeywords
                                    saveOrder()
                                }
                                .disableAutocorrection(false)
                                .focused($isFocused)
                        }
                    }
                    .onDelete(perform: { deleteItem(at: $0, from: &cakeSideItems, keywords: &cakeSideKeywords) })
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(SidebarListStyle())
            .listRowBackground(Color.clear)
            .background(Color.clear)
            .scrollContentBackground(.hidden)
        }
    }
    
    private var totalItems: Int {
        cakeTopItems.count + cakeSideItems.count
    }
    
    private func addItem(to list: inout [Int], keywords: inout [String]) {
        guard totalItems < 5 else { return }
        list.append(list.count)
        keywords.append("") // Add a new empty string to the keywords array
    }
    
    private func deleteItem(at offsets: IndexSet, from list: inout [Int], keywords: inout [String]) {
        list.remove(atOffsets: offsets)
        keywords.remove(atOffsets: offsets)
    }
    
    private func limitText(_ newValue: String, in array: inout [String], at index: Int, upper: Int) {
        if newValue.count > upper {
            array[index] = String(newValue.prefix(upper))
        }
    }
}

// MARK: - 저장함수
private func saveOrder() {
    CoredataManager.shared.saveOrUpdateOrder()
}

#Preview {
    test8()
}

