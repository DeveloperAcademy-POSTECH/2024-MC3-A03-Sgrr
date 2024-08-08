//
//  TextFiedlCell.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 8/7/24.
//

import SwiftUI


struct TextfieldCell: View {
    let direction: CakeDirection
    @Binding var cakeElement: CakeElement
    @State var elementArray: [String] = []
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    if direction == .top {
                        Text("윗면")
                            .font(.system(size: 13))
                            .fontWeight(.bold)
                            .foregroundStyle(.main)
                    } else {
                        Text("옆면")
                            .font(.system(size: 13))
                            .fontWeight(.bold)
                            .foregroundStyle(.main)
                    }
                    
                    Spacer()
                }
                HStack {
                    
                    TextField("텍스트를 입력하세요", text: $cakeElement.elementKeyword)
                        .maxLength(text: $cakeElement.elementKeyword, 13)
                        .foregroundColor(.black)
                       
                    
                        .onChange(of: cakeElement.elementKeyword) {
                            elementArray.append(cakeElement.elementKeyword)
                        }
                        .disableAutocorrection(false)
                }
//                .padding()
                
            }
            .onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
            }
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .frame(height: 62)
    }
    
}

// 글자수 제한 modifeir
struct MaxLengthModifier: ViewModifier {
    @Binding var text: String
    let maxLength: Int

    func body(content: Content) -> some View {
        content
            .onChange(of: text) { oldValue, newValue in
                if newValue.count > maxLength {
                    text = oldValue
                }
            }
    }
}


// 글자수 제한 method
extension TextField {
    func maxLength(text: Binding<String>, _ maxLength: Int) -> some View {
        return ModifiedContent(content: self,
                               modifier: MaxLengthModifier(text : text,
                                                           maxLength: maxLength))
    }
}


//
//#Preview {
//    
//    TextfieldCell(cakeElement: )
//}
