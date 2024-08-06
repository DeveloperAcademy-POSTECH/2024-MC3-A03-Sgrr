//
//  CakeTopImageCell.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 8/6/24.
//

import SwiftUI
import PhotosUI
import Combine

struct CakeTopImageCell: View {
    
    @State var cakeTopImages: UIImage?
    @State var photosPickerItem: PhotosPickerItem?
    
    @State var text: String
    private let characterLimit: Int = 15
    @FocusState var isFocused: Bool
    
    var body: some View {
        
        PhotosPicker(selection: $photosPickerItem, matching: .images) {
            
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
                
                if let cakeTopImages = cakeTopImages {
                    Image(uiImage: cakeTopImages)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 62, height: 62)
                        .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                }
                
            }
            
        }
        .onChange(of: photosPickerItem) { _, _ in
            Task {
                if let photosPickerItem,
                   let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        cakeTopImages = image
                    }
                }
            }
        }
    }
}

