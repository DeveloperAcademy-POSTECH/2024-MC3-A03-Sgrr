//
//  ComponentView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI

struct ComponentView: View {
    
    @State private var cakeTopItems: [Int] = []
    
    
    var body: some View {

            VStack {
                ZStack {
                    Rectangle()
                        .cornerRadius(10, corners: [.topLeft, .topRight])
                        .frame(width:393, height: 95)
                        .foregroundColor(Color(hex: "FAC0B5"))
                    Text("요소")
                        .foregroundColor(Color(hex: "FFFCF1"))
                        .font(.system(size: 34))
                        .fontWeight(.black)
                        .padding(.trailing, 280)
                        .padding(.top, 30)
                }
                
                
                
                
                List {
                    Section(header: Text("케이크 윗면")) {
                        ImageAddView()
                        ForEach(cakeTopItems.indices, id: \.self) { index in
                            ImageAddView()
                        }
                       
                        .onDelete(perform: deleteItem)
                        
                        Button {
                            cakeTopItems.append(cakeTopItems.count)
                        } label: {
                            Image(systemName: "plus")
                        }
                       
                    }
                    
                    
                    Section(header: Text("케이크 옆면")) {
                      
                    }
                }
                .background(Color.clear)
                .scrollContentBackground(.hidden)
                
            
               
                
                Spacer()
                
               
            }

    }
    
    private func deleteItem(at offsets: IndexSet) {
           cakeTopItems.remove(atOffsets: offsets)
       }
    
}

#Preview {
    ComponentView()
}
