//
//  ColorView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI

struct ColorCell: View {


    
    @Binding var selectedBGColor: Color
    @Binding var selectedLetteringColor: Color
    @Binding var bgColorToString: String
    @Binding var letteringColorToString: String

    var body: some View {
            VStack {
                ZStack {
                    Rectangle()
                        .frame(width:393, height: 95)
                        .foregroundColor(Color(hex: "FA5738"))
                    Text("컬러")
                        .foregroundColor(Color(hex: "FFFCF1"))
                        .font(.system(size: 34))
                        .fontWeight(.black)
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
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                            .padding(.leading, 16)
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
//                                                saveOrder()
                                                print("hello")
                                            }
                                        
                                        Text("#\(selectedBGColor.toHex() ?? "N/A")")
                                            .foregroundColor(.gray)
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
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                            .padding(.leading, 16)
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
//                                                cakeData.cake.colorLetter = hex
//                                                saveOrder()
                                                print("hello")
                                            }
                                        
                                        Text("#\(selectedLetteringColor.toHex() ?? "N/A")")
                                            .foregroundColor(.gray)
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



//#Preview {
//   ColorCell()
//}

