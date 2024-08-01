//
//  ImageAddView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI
import PhotosUI

struct ImageAddView: View {
    
    @State private var referenceImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
        
        PhotosPicker(selection: $photosPickerItem, matching: .images) {
            
            ZStack {
                Rectangle()
                    .frame(width: 62, height: 62)
                // 이블린 이꺼 둥근 모서리 쓰면 돼!
                    .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                    .foregroundColor(.white)
                    .border(width: 0.5, edges: [.trailing], color: Color(hex: "D9D9D9"))
                Image("ImageIcon")
                    .resizable()
                    .frame(width: 30, height: 24)
                    .scaledToFit()
                
                if let referenceImage = referenceImage {
                    Image(uiImage: referenceImage)
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
                        referenceImage = image
                    }
                }
            }
        }
    }
}


#Preview {
    ImageAddView()
}
