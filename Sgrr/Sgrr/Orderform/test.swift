

import SwiftUI
import Combine
import PhotosUI

struct test: View {
    private var cakeData = CoredataManager.shared
    
    // 이미지
    @State var cakeTopItems: [Int] = [0]
    @State var cakeSideItems: [Int] = [0]
    
    @State private var cakeTopImages: [UIImage] = []
    @State private var photosPickerTopImages: [PhotosPickerItem] = []
    
    @State private var cakeSideImages: [UIImage] = []
    @State private var photosPickerSideImages: [PhotosPickerItem] = []
    
    
    
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
                        addItem(to: &cakeTopItems, keywords: &cakeTopKeywords)
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color(hex: "FA5738"))
                    }
                    .disabled(totalItems >= 5)
                }) {
                    ForEach(cakeTopItems.indices, id: \.self) { index in
                        HStack {
//                            ImageAddView(imageIndex: index, cakeTopImages: $cakeTopImages)
                            
                            // 텍스트필드
                            ZStack {
                                VStack {
                                    HStack {
                                        //사용자 입력을 받는 텍스트 필드
                                        TextField("텍스트를 입력하세요", text: $cakeTopKeywords[index])
                                            .foregroundColor(.black)
                                        // 텍스트 값이 변경될 때마다 글자 수 제한 함수 호출
                                            .onReceive(Just(cakeTopKeywords[index])) { newValue in
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
                                    .onAppear {
                                        a(a: "B", b: 3, c: false)
                                    }
                                    
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
//                            ImageAddView(imageIndex: index, cakeTopImages: $cakeTopImages)
                            
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
    test()
}

extension test {
    func a(a: String, b: Int, c: Bool) {
        print("\(a), \(b), \(c)")
    }
}
