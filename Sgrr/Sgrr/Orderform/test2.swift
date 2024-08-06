//
//  test2.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 8/6/24.
//

// 티나의 도전!


import SwiftUI
import Combine
import PhotosUI

struct test2: View {
    
    private var cakeData = CoredataManager.shared
    
    @State private var conceptImage: UIImage?
    @State private var photosPickerConceptItem: PhotosPickerItem?
    
    @State private var cakeTopKeyword: String = "" //컨셉
    @State private var cakeTopKeywordList: [String] = [""]
    private let characterLimit: Int = 15     //최대 글자 수 제한
    @FocusState private var isFocused: Bool  //텍스트 필드의 포커스 상태를 관리하는 상태 변수

    var body: some View {

        VStack (spacing: 0) {
                ZStack {
                    Rectangle()
                        .frame(width:393, height: 95)
                        .foregroundColor(Color(hex: "FA8C76"))
                    Text("컨셉")
                        .foregroundColor(Color(hex: "FFFCF1"))
                        .font(.system(size: 34))
                        .fontWeight(.black)
                        .padding(.trailing, 280)
                        .padding(.top, 30)
                }
                
                List {
                    HStack {
                        
                        // MARK: 포토피커
//                        CakeTopImageCell(text: <#T##String#>)
                      
                        
                        // MARK: 텍스트 필드
                        ZStack {
                            VStack {
                                HStack {
                                    TextField("텍스트를 입력하세요", text: $cakeTopKeyword)
                                        .foregroundColor(.black)
                                        .onReceive(Just(cakeTopKeyword)) { newValue in
                                            limitText(newValue, upper: characterLimit)
                                        }
                                        .onChange(of: cakeTopKeyword) {
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
    test2()
}

