//
//  ColorAddView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/30/24.
//

import SwiftUI

// title, color - 구조체로 만들어서 데이터를 넘겨줘라

class ColorData: ObservableObject {
    @Published var colorTitle: String
    @Published var selectedColor: Color
    
    init(colorTitle: String, selectedColor: Color) {
            self.colorTitle = colorTitle
            self.selectedColor = selectedColor
        }
    
}

struct ColorAddView: View {
    
    @ObservedObject var colorData: ColorData
    
    
    var body: some View {
        
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 162, height: 217)
            .foregroundColor(.white)
            .overlay() {
                VStack {
                    HStack {
                        Text("\(colorData.colorTitle)")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .padding(.leading, 16)
                        Spacer()
                    }
                    Circle()
                        .foregroundColor(colorData.selectedColor)
                        .frame(width: 107, height: 107)
                        .shadow(color: .gray, radius: 3, x: 2, y: 2)
                    
                    HStack {
                        ColorPicker("", selection: $colorData.selectedColor)
                            .labelsHidden()
                        
                        Text("#\(colorData.selectedColor.toHex() ?? "N/A")")
                            .foregroundColor(.gray)
                    }
                    
                }
            }
    }
}




#Preview {
    ColorAddView(colorData: ColorData(colorTitle: "예시문구", selectedColor: .blue))
}
