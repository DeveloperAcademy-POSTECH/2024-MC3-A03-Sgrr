//
//  ConceptView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI
import Combine
import PhotosUI

struct ConceptView: View {
    
    private var cakeData = CoredataManager.shared
    
    @State private var conceptImage: UIImage?
    @State private var photosPickerConceptItem: PhotosPickerItem?
    
    @State private var conceptKeyword: String = "" //컨셉
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
                        // 이미지
                        
//                        ImageAddView()
//                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//                        
                        PhotosPicker(selection: $photosPickerConceptItem, matching: .images) {
                            
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
                                
                                if let conceptImage = conceptImage {
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
                                        conceptImage = image
                                        cakeData.cake.conceptImg = data
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
                                    TextField("텍스트를 입력하세요", text: $conceptKeyword)
                                        .foregroundColor(.black)
                                    // 텍스트 값이 변경될 때마다 글자 수 제한 함수 호출
                                        .onReceive(Just(conceptKeyword)) { newValue in
                                            limitText(newValue, upper: characterLimit)
                                        }
                                        .onChange(of: conceptKeyword) {
                                            cakeData.cake.conceptKey = conceptKeyword
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
            conceptKeyword = String(newValue.prefix(upper))
        }
    }
}

// MARK: - 저장함수
private func saveOrder() {
    CoredataManager.shared.saveOrUpdateOrder()
}

#Preview {
    ConceptView()
}
