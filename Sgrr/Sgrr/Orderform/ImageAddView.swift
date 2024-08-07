//
//  ImageAddView.swift
//  Sgrr
//
//  Created by KIM SEOWOO on 7/31/24.
//

import SwiftUI
import PhotosUI

struct ImageAddView: View {
    @Binding var text: String?
    var body: some View {
        Text(text ?? "요소 키워드를 작성해주세요.")
    }
}

//struct ImageAddView: View {
//    var imageIndex: Int
//    @Binding var cakeTopImages: [UIImage]
//    //    @Binding var cakeSideImages: [UIImage]
//    @State private var photosPickerItem: PhotosPickerItem?
//    
//    var body: some View {
//        
//        PhotosPicker(selection: $photosPickerItem, matching: .images) {
//            
//            ZStack {
//                Rectangle()
//                    .frame(width: 62, height: 62)
//                // 이블린 이꺼 둥근 모서리 쓰면 돼!
//                    .cornerRadius(10, corners: [.topLeft, .bottomLeft])
//                    .foregroundColor(.white)
//                //                    .border(width: 0.5, edges: [.trailing], color: Color(hex: "D9D9D9"))
//                Image("ImageIcon")
//                    .resizable()
//                    .frame(width: 30, height: 24)
//                    .scaledToFit()
//                
//                
//                if imageIndex < cakeTopImages.count {
//                    let referenceImage = cakeTopImages[imageIndex]
//                    Image(uiImage: referenceImage)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 62, height: 62)
//                        .cornerRadius(10, corners: [.topLeft, .bottomLeft])
//                }
//            }
//            
//        }
//        .onChange(of: photosPickerItem) { _, _ in
//            Task {
//                if let photosPickerItem,
//                   let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
//                    if let image = UIImage(data: data) {
//                        cakeTopImages.append(image)
//                    }
//                }
//            }
//        }
//    }
//}
//
//
////#Preview {
////    ImageAddView()
////}
