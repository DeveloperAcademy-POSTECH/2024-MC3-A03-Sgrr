//
//  ColorView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI

struct ColorCell: View {
    
    @State var selectedBGColor: Color = .white
    @State var selectedLetteringColor: Color = .white
    @Binding var bgColorToString: String
    @Binding var letteringColorToString: String
    
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
                                            bgColorToString = hex
                                            print("changeColor")
                                        }
                                    
                                    Text("#\(selectedBGColor.toHex() ?? "N/A")")
                                        .font(.hexText)
                                        .foregroundStyle(Color.gray)
                                }
                                .padding(.top, 10)
                                
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
                                            letteringColorToString = hex
                                            print("changeColor")
                                        }
                                    
                                    Text("#\(selectedLetteringColor.toHex() ?? "N/A")")
                                        .font(.hexText)
                                        .foregroundStyle(Color.gray)
                                }
                                .padding(.top, 10)
                                
                            }
                        }
                }
                .padding(.trailing, 26)
                .padding(.leading, 26)
                .padding(.top, 16)
                Spacer()
            }
        }
    }
}


//#Preview {
//    ColorCell()
//}

