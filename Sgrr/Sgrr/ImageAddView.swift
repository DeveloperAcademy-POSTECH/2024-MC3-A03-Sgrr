//
//  ImageAddView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI
import PhotosUI

struct ImageAddView: View {
    
    @State private var avartarImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
        
        PhotosPicker(selection: $photosPickerItem, matching: .images) {
            
            ZStack {
                Rectangle()
                    .frame(width: 62, height: 62)
                    .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                    .foregroundColor(.white)
                Image(uiImage: (avartarImage ?? UIImage(named: "ImageIcon"))!)
                    .resizable()
                    .frame(width: 30, height: 24)
                    .scaledToFill()
            }
            
        }
        .onChange(of: photosPickerItem) { _, _ in
            Task {
                if let photosPickerItem,
                   let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        avartarImage = image
                    }
                }
            }
        }
    }
}


#Preview {
    ImageAddView()
}
