


import SwiftUI
import Combine
import PhotosUI

// 케이크 윗면, 옆면
enum CakeDirection {
    case top
    case side
}

struct CakeElement: Identifiable {
    var id: UUID = UUID()
    var elementimage: UIImage?
    var cakeDirection: CakeDirection
    var elementKeyword: String
}

struct ElementView: View {
    
    @State private var cakeElementList: [CakeElement] = [
        .init(cakeDirection: .top, elementKeyword: ""),
        .init(cakeDirection: .side, elementKeyword: "")
    ]
    
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
                } header: {
                    HStack {
                        Text("케이크 윗면")
                            .font(.elementListTitle)
                            .foregroundStyle(.gray)
                        
                        Spacer()
                        Button {
                            let newElementList = CakeElement(elementimage: nil, cakeDirection: .top, elementKeyword: "")
                            cakeElementList.append(newElementList)
                        } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(.main)
                                .font(.system(size: 13))
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                Section {
                    ForEach($cakeElementList.filter {$0.wrappedValue.cakeDirection == .side}) { $cakeElement in
                        HStack {
                            ImageCell(cakeElement: $cakeElement)
                            TextfieldCell(direction: .side, cakeElement: $cakeElement)
                        }
                    }
                } header: {
                    HStack {
                        Text("케이크 옆면")
                            .font(.elementListTitle)
                            .foregroundStyle(.gray)
                        Spacer()
                        Button {
                            let newElementList = CakeElement(elementimage: nil, cakeDirection: .side, elementKeyword: "")
                            cakeElementList.append(newElementList)
                        } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(.main)
                                .font(.system(size: 13))
                        }
                    }
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

// MARK: - 저장함수
private func saveOrder() {
    CoredataManager.shared.saveOrUpdateOrder()
}

#Preview {
    ElementView()
}


