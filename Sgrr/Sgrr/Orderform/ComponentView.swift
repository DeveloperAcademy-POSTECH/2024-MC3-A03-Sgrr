

import SwiftUI
import Combine
import PhotosUI

enum CakeDesignSide {
    case top
    case side
}

struct CakeKeyword: Identifiable {
    var id: UUID = UUID()
    var image: UIImage?
    var designSide: CakeDesignSide
    var keyword: String
}

struct ComponentView: View {
//    private var cakeData = CoredataManager.shared
    
    @State private var referenceTopImage: UIImage?
    @State private var referenceSideImage: UIImage?
    @State private var photosPickerTopItem: PhotosPickerItem?
    @State private var photosPickerSideItem: PhotosPickerItem?
    
    @State var inputElementImage: Data = Data()
    
    // 이미지
    @State var cakeTopItems: [Int] = [0]
    @State var cakeSideItems: [Int] = [0]
   
    // 키워드
    @State var cakeTopKeywords: [String] = [""]
    @State var cakeSideKeywords: [String] = [""]
    
    // Hi Austin
    @State private var cakeKeywordList: [CakeKeyword] = [
        CakeKeyword(image: nil, designSide: .top, keyword: "default")
    ]

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
            
            // Hi Austin 2
            List {
                Section {
                    ForEach($cakeKeywordList.filter { $0.wrappedValue.designSide == .top }) { $cakeKeyword in
                        HStack {
                            AustinImageAddView(cakeKeyword: $cakeKeyword)
                            Text(cakeKeyword.keyword)
                        }
                    }
                } header: {
                    HStack {
                        Text("케이크 윗면")
                        Spacer()
                        Button {
                            let newCake = CakeKeyword(image: nil, designSide: .top, keyword: "")
                            cakeKeywordList.append(newCake)
                        } label: {
                            Text("+")
                        }
                    }
                }
                Section {
                    ForEach(cakeKeywordList.filter { $0.designSide == .side }) { cakeKeyword in
                        Text(cakeKeyword.keyword)
                    }
                } header: {
                    HStack {
                        Text("케이크 옆면")
                        Spacer()
                        Button {
                            let newCake = CakeKeyword(image: nil, designSide: .side, keyword: "")
                            cakeKeywordList.append(newCake)
                        } label: {
                            Text("+")
                        }
                    }
                }
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
                            PhotosPicker(selection: $photosPickerTopItem, matching: .images) {
                                
                                ZStack {
                                    Rectangle()
                                        .frame(width: 62, height: 62)
                                    // 이블린 이꺼 둥근 모서리 쓰면 돼!
                                        .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                                        .foregroundColor(.white)
                    //                    .border(width: 0.5, edges: [.trailing], color: Color(hex: "D9D9D9"))
                                    Image("ImageIcon")
                                        .resizable()
                                        .frame(width: 30, height: 24)
                                        .scaledToFit()
                                    
                                    if let referenceImage = referenceTopImage {
                                        Image(uiImage: referenceImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 62, height: 62)
                                            .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                                    }
                                 
                                }
                                
                            }
                            .onChange(of: photosPickerTopItem) { _, _ in
                                Task {
                                    if let photosPickerTopItem,
                                       let data = try? await photosPickerTopItem.loadTransferable(type: Data.self) {
                                        if let image = UIImage(data: data) {
                                            referenceTopImage = image
                                            inputElementImage = data
//                                            cakeData.cake.elementImg.append(inputElementImage)
                                        }
                                    }
                                }
                            }
                            
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
//                                                cakeData.cake.elementTopKey = cakeTopKeywords
//                                                saveOrder()
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
                            PhotosPicker(selection: $photosPickerSideItem, matching: .images) {
                                
                                ZStack {
                                    Rectangle()
                                        .frame(width: 62, height: 62)
                                    // 이블린 이꺼 둥근 모서리 쓰면 돼!
                                        .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                                        .foregroundColor(.white)
                    //                    .border(width: 0.5, edges: [.trailing], color: Color(hex: "D9D9D9"))
                                    Image("ImageIcon")
                                        .resizable()
                                        .frame(width: 30, height: 24)
                                        .scaledToFit()
                                    
                                    if let referenceImage = referenceSideImage {
                                        Image(uiImage: referenceImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 62, height: 62)
                                            .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                                    }
                                 
                                }
                                
                            }
                            .onChange(of: photosPickerSideItem) { _, _ in
                                Task {
                                    if let photosPickerSideItem,
                                       let data = try? await photosPickerSideItem.loadTransferable(type: Data.self) {
                                        if let image = UIImage(data: data) {
                                            referenceTopImage = image
                                            inputElementImage = data
//                                            cakeData.cake.elementImg.append(inputElementImage)
                                        }
                                    }
                                }
                            }
                            // 텍스트 필드
                            TextField("텍스트를 입력하세요", text: $cakeSideKeywords[index])
                                .foregroundColor(.black)
                                .onReceive(Just(cakeSideKeywords[index])) { newValue in
                                    limitText(newValue, in: &cakeSideKeywords, at: index, upper: characterLimit)
                                }
                                .onChange(of: cakeSideKeywords[index]) {
//                                    cakeData.cake.elementSideKey = cakeSideKeywords
//                                    saveOrder()
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


#Preview {
    ComponentView()
}

