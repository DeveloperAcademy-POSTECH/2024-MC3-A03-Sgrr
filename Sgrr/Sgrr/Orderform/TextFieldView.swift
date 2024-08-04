//
//  TextFieldView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 8/2/24.
//

import SwiftUI
import Combine


struct TextFieldView: View {
    
    private var cakeData = CoredataManager.shared


    //사용자 입력을 저장하는 상태 변수
    @State private var text: String
    //최대 글자 수 제한
    private let characterLimit: Int = 15
    //텍스트 필드의 포커스 상태를 관리하는 상태 변수
    @FocusState private var isFocused: Bool

    var body: some View {

        ZStack {
//            Color(.blue)
            VStack {
                HStack {
                    //사용자 입력을 받는 텍스트 필드
                    TextField("텍스트를 입력하세요", text: $text)
                    // 텍스트 값이 변경될 때마다 글자 수 제한 함수 호출
                        .onReceive(Just(text)) { newValue in
                            limitText(newValue, upper: characterLimit)
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
    // 입력된 텍스트의 글자 수를 제한하는 함수
    private func limitText(_ newValue: String, upper: Int) {
        if newValue.count > upper {
            text = String(newValue.prefix(upper))
        }
    }
}
