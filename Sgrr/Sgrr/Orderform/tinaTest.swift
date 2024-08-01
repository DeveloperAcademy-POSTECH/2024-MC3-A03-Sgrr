//
//  tinaTest.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 8/1/24.
//

//
//  ComponentView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI

struct tinatest: View {
    
    @State private var cakeTopItems: [Int] = []
    @State private var cakeSideItems: [Int] = []
    
    
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
                    Section(header: HStack {
                        Text("케이크 윗면")
                        Spacer()
                        Button {
                            cakeTopItems.append(cakeTopItems.count)
                        } label: {
                            Image(systemName: "plus")
                        }
                        .disabled(totalItems >= 5)
                        
                    }) {
                      
                           
                        ForEach(cakeTopItems.indices, id: \.self) { index in
                            ImageAddView()
                            
                            
                        }
                        .onDelete(perform: deleteItem)
                    }
                    .listRowSeparator(.hidden)
                   
                    
                    
                    Section(header: HStack {
                        Text("케이크 옆면")
                        Spacer()
                        Button {
                            cakeSideItems.append(cakeSideItems.count)
                        } label: {
                            Image(systemName: "plus")
                               
                        }
                        .disabled(totalItems >= 5)
                    }) {
                      
                           
                        ForEach(cakeSideItems.indices, id: \.self) { index in
                            ImageAddView()
                        }
                        .onDelete(perform: deleteItem)
                    }
                    .listRowSeparator(.hidden)
                   
                }
             
                .listStyle(SidebarListStyle())
                .background(Color.clear)
                .scrollContentBackground(.hidden)
                
            
               
                
                Spacer()
                
               
            }

    }
    
    private var totalItems: Int {
        cakeTopItems.count + cakeSideItems.count
    }
    
    private func deleteItem(at offsets: IndexSet) {
           cakeTopItems.remove(atOffsets: offsets)
       }
    
}

#Preview {
   tinatest()
}

