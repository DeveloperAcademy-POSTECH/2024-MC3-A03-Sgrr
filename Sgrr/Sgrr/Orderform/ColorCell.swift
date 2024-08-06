//
//  ColorView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI

struct ColorCell: View {
    
    private var cakeData = CoredataManager.shared
    
    @State var selectedBGColor: Color = .white
    @State var selectedLetteringColor: Color = .white
    @State var bgColorToString: String = ""
    @State var letteringColorToString: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(width:393, height: 95) // 여백이랑 패딩 고정하기
                    .foregroundStyle(.main)
                
                Text("컬러")
                    .foregroundStyle(.bg)
                    .font(.orderFormTitle)
                    .padding(.trailing, 280)
                    .padding(.top, 30)
            }
            
            Spacer()
            
            //LazyHStack
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 162, height: 217)
                        .foregroundColor(.white)
                        .overlay() {
                            VStack {
                                HStack {
                                    Text("배경")
                                        .font(.colorTitle)
                                        .padding(.leading, 16)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                Circle()
                                    .foregroundColor(selectedBGColor)
                                    .frame(width: 107, height: 107)
                                    .shadow(color: .gray, radius: 3, x: 2, y: 2)
                                
                                HStack {
                                    ColorPicker("", selection: $selectedBGColor)
                                        .labelsHidden()
                                        .onChange(of: selectedBGColor) {
                                            guard let hex = selectedBGColor.toHex() else {
                                                return
                                            }
                                            cakeData.cake.colorBG = hex
                                            saveOrder()
                                            print("hello")
                                        }
                                    
                                    Text("#\(selectedBGColor.toHex() ?? "N/A")")
                                        .font(.hexText)
                                        .foregroundStyle(Color.gray)
                                }
                                
                            }
                        }
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 162, height: 217)
                        .foregroundColor(.white)
                        .overlay() {
                            VStack {
                                HStack {
                                    Text("레터링")
                                        .font(.colorTitle)
                                        .padding(.leading, 16)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                Circle()
                                    .foregroundColor(selectedLetteringColor)
                                    .frame(width: 107, height: 107)
                                    .shadow(color: .gray, radius: 3, x: 2, y: 2)
                                
                                HStack {
                                    ColorPicker("", selection: $selectedLetteringColor)
                                        .labelsHidden()
                                        .onChange(of: selectedLetteringColor) {
                                            guard let hex = selectedLetteringColor.toHex() else {
                                                return
                                            }
                                            cakeData.cake.colorLetter = hex
                                            saveOrder()
                                            
                                        }
                                    
                                    Text("#\(selectedLetteringColor.toHex() ?? "N/A")")
                                        .font(.hexText)
                                        .foregroundStyle(Color.gray)
                                }
                                
                            }
                        }
                }
                .padding(.trailing, 22)
                .padding(.leading, 22)
                .padding(.top, 22)
                Spacer()
            }
        }
    }
}

// MARK: - 저장함수
private func saveOrder() {
    CoredataManager.shared.saveOrUpdateOrder()
}

#Preview {
    ColorCell()
}

