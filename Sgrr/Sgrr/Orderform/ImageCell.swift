//
//  ImageCell.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 8/7/24.
//

import SwiftUI
import PhotosUI

struct ImageCell: View {
    
    @Binding var cakeElement: CakeElement
   
    @State private var photosPickerElementItem: PhotosPickerItem?
    
    
    var body: some View {
        // MARK: 포토피커
        PhotosPicker(selection: $photosPickerElementItem, matching: .images) {
            ZStack {
                Rectangle()
                    .frame(width: 62, height: 62)
                    .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                    .foregroundColor(.white)
//                    .border(width: 0.5, edges: [.trailing], color: Color(hex: "D9D9D9"))
                Image("ImageIcon")
                    .resizable()
                    .frame(width: 30, height: 24)
                    .scaledToFit()
                
                if let referenceImage = cakeElement.photoPickerImage {
                    Image(uiImage: referenceImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 62, height: 62)
                        .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                }
            }
        }
        .onChange(of: photosPickerElementItem) { _, _ in
            Task {
                if let photosPickerElementItem,
                   let data = try? await photosPickerElementItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        cakeElement.photoPickerImage = image
                        cakeElement.elementImage = data
                    }
                }
               
            }
        }
    }
}

//#Preview {
//    ImageCell(cakeElement: .constant(CakeElement(cakeDirection: .top, elementKeyword: "100")))
//}


