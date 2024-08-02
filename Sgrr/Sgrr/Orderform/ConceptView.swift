//
//  ConceptView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI

struct ConceptView: View {
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
                        ImageAddView()
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//                        TextFieldView()
                    }
                        
                }
                .listStyle(SidebarListStyle())
                .listRowBackground(Color.clear)
                .background(Color.pink)
                .scrollContentBackground(.hidden)
                
            }

    }
}

#Preview {
    ConceptView()
}
