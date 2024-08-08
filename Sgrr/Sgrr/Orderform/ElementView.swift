


import SwiftUI
import Combine
import PhotosUI


struct ElementView: View {
    
    @Binding var cakeElementList: [CakeElement]
    
    private var isPlusButtonDisabled: Bool {
             return cakeElementList.count >= 5
         }
       
       private func onDelete(at offsets: IndexSet) {
            cakeElementList.remove(atOffsets: offsets)
        }
       
    
    var body: some View {
        VStack (spacing: 0) {
            ZStack {
                Rectangle()
                    .frame(width: 393, height: 95)
                    .foregroundStyle(.round)
                Text("요소")
                    .foregroundStyle(.bg)
                    .font(.system(size: 34))
                    .fontWeight(.black)
                    .padding(.trailing, 280)
                    .padding(.top, 30)
            }
            
            List {
                Section {
                    ForEach($cakeElementList.filter {$0.wrappedValue.cakeDirection == .top}) { $cakeElement in
                        HStack {
                            ImageCell(cakeElement: $cakeElement)
                            TextfieldCell(direction: .top, cakeElement: $cakeElement)
                        }
                    }
                    .onDelete(perform: onDelete)
                } header: {
                    HStack {
                        Text("케이크 윗면")
                            .font(.elementListTitle)
                            .foregroundStyle(.gray)
                        
                        Spacer()
                        Button {
                            let newElementList = CakeElement(id: UUID(), elementKeyword: "", photoPickerImage: nil, cakeDirection: .top)
                            cakeElementList.append(newElementList)
                        } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(.main)
                                .font(.system(size: 13))
                        }
                    }
                    .disabled(isPlusButtonDisabled)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                Section {
                    ForEach($cakeElementList.filter {$0.wrappedValue.cakeDirection == .side}) { $cakeElement in
                        HStack {
                            ImageCell(cakeElement: $cakeElement)
                            TextfieldCell(direction: .side, cakeElement: $cakeElement)
                        }
                    }
                    .onDelete(perform: onDelete)
                } header: {
                    HStack {
                        Text("케이크 옆면")
                            .font(.elementListTitle)
                            .foregroundStyle(.gray)
                        Spacer()
                        Button {
                            let newElementList = CakeElement(id: UUID(), elementKeyword: "", photoPickerImage: nil, cakeDirection: .side)
                            cakeElementList.append(newElementList)
                        } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(.main)
                                .font(.system(size: 13))
                        }
                    }
                    .disabled(isPlusButtonDisabled)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .padding(.top, 16)
            .listStyle(SidebarListStyle())
            .listRowBackground(Color.clear)
            .background(Color.clear)
            .scrollContentBackground(.hidden)
        }
    }
    
}

//
//#Preview {
//    ElementView()
//}


