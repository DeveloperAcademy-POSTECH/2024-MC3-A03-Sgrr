//
//  TestComponentView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 8/6/24.
//

//
//  ConceptView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI
import Combine
import PhotosUI

struct TestComponentView: View {
    
    private var cakeData = CoredataManager.shared
    
    @State private var cakeTopImage: UIImage?
    @State private var photosPickerCakeTopItem: PhotosPickerItem?
    
    
    // 텍스트필드
    @State var cakeTopItems: [String: String] = ["앞면":""]
    @State var cakeSideItems: [String: String] = ["옆면":""]
    
    @State var cakeTopKeyword: String = ""
    @State var cakeSideKeyword: String = ""
    
    private let characterLimit: Int = 15     //최대 글자 수 제한
    @FocusState private var isFocused: Bool  //텍스트 필드의 포커스 상태를 관리하는 상태 변수

    var body: some View {

        VStack (spacing: 0) {
                ZStack {
                    Rectangle()
                        .frame(width:393, height: 95)
                        .foregroundColor(Color(hex: "FA8C76"))
                    Text("요소")
                        .foregroundColor(Color(hex: "FFFCF1"))
                        .font(.system(size: 34))
                        .fontWeight(.black)
                        .padding(.trailing, 280)
                        .padding(.top, 30)
                }
                
                List {
                    
                    HStack {
                        // MARK: 케이크 윗면 PhotoPicker
                        PhotosPicker(selection: $photosPickerCakeTopItem, matching: .images) {
                            ZStack {
                                Rectangle()
                                    .frame(width: 62, height: 62)
                                    .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                                    .foregroundColor(.white)
            
                                Image("ImageIcon")
                                    .resizable()
                                    .frame(width: 30, height: 24)
                                    .scaledToFit()
                                
                                if let cakeTopImage = cakeTopImage {
                                    Image(uiImage: cakeTopImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 62, height: 62)
                                        .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                                }
                             
                            }
                            
                        }
                        
                        .onChange(of: photosPickerCakeTopItem) { _, _ in
                            Task {
                                if let photosPickerCakeTopItem,
                                   let data = try? await photosPickerCakeTopItem.loadTransferable(type: Data.self) {
                                    if let image = UIImage(data: data) {
                                        cakeTopImage = image
//                                        cakeData.cake.elementImg = data
                                        saveOrder()
                                    }
                                }
                               
                            }
                        }
                      
                        
                        // MARK: 케이크 윗면 TextField
                        ZStack {
                            VStack {
                                HStack {
                                    TextField("텍스트를 입력하세요", text: $cakeTopKeyword)
                                        .foregroundColor(.black)
                                        .onReceive(Just(cakeTopKeyword)) { newValue in
                                            limitCakeTopKeyword(newValue, upper: characterLimit)
                                        }
                                        .onChange(of: cakeTopKeyword) { newValue in
                                            cakeTopItems["앞면"] = newValue
//                                            cakeData.cake.elementKey = cakeTopKeyword
                                            saveOrder()
                                        }
                                        .disableAutocorrection(false)
                                        .focused($isFocused)
                                }
                                .padding()
                                
                            }
                            .onAppear {
                                UITextField.appearance().clearButtonMode = .whileEditing
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
               
                .listStyle(SidebarListStyle())
                .listRowBackground(Color.clear)
                .background(Color.clear)
                .scrollContentBackground(.hidden)
                
            }
    }
    private func limitCakeTopKeyword(_ newValue: String, upper: Int) {
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
   TestComponentView()
}

