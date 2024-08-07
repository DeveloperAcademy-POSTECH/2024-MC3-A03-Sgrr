//
//  FinalGuideView.swift
//  Sgrr
//
//  Created by Lee Wonsun on 8/1/24.
//


import SwiftUI
import Photos

struct FinalGuideView: View {
    @EnvironmentObject var router: Router
    @Environment(\.presentationMode) var presentationMode
    
    @State private var screenshotImage: UIImage?
    @State private var showingAlert = false
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @FetchRequest(
        entity: OrderForm.entity(),
        sortDescriptors: [] // 정렬 기준 없이 모든 데이터를 가져옴
    ) private var orderForms: FetchedResults<OrderForm>
    
    var orderForm: OrderForm {
        guard let order = orderForms.last else {
            return OrderForm()
        }
        return order
    }
    
    var combinedImage: [Data] {
        var images: [Data] = orderForm.elementImage ?? []
        if let conceptImage = orderForm.conceptImage {
            images.insert(conceptImage, at: 0)
        }
        return images
    }
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                ZStack {
                    Color.bg
                        .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        guideTitle()
                            .padding(.bottom, 20)
                            .padding(.top, -20)
                        
                        // 이미지 6개 컴포넌트
                        imageVGrid()
                            .padding(.horizontal, 16)
                            .padding(.bottom, 24)
                        
                        FinalColorComponent(selectedBg: orderForm.colorBackground ?? "", selectedLetter: orderForm.colorLettering ?? "")
                            .padding(.bottom, 22)
                        
                        FinalConceptKeywordComponent()
                            .padding(.bottom, 22)
                        
                        FinalElementKeywordComponent()
                        
                        Spacer()
                        
                    } .padding(.bottom, -11)
                    
                }
            }
            .background(Color.bg)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 5) {
                        
                        if let image = screenshotImage {
                                           Image(uiImage: image)
                                               .resizable()
                                               .scaledToFit()
                                               .frame(width: 200, height: 200)
                                       }
                                       
                                       Button(
                                           action: {
                                               share()
                                           },
                                           label: {
                                               Image(systemName: "square.and.arrow.up")
                                                   .foregroundStyle(.main)
                                           }
                                       )
                                           .padding(.bottom, 3.5)
                                           .alert(isPresented: $showingAlert) {
                                               Alert(title: Text("Saved"), message: Text("Screenshot saved to Photos"), dismissButton: .default(Text("OK")))
                                           }

                        
                        
                        
                        Button(action: {
                            router.backToHome()
                        }, label: {
                            Image(systemName: "square.and.pencil")
                                .foregroundStyle(.main)
                        }) .padding(.bottom, 3.5)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.main)
                        }
                    }
                }
            }
        
    }
    
    // MARK: - 디자인가이드 타이틀
    @ViewBuilder
    func guideTitle() -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Cakey")
                    .font(.englishLargeTitle)
                    .padding(.bottom, 1)
                Text("케이크 가이드")
                    .font(.koreanLargeTitle)
            }
            .padding(.top, 18)
            .foregroundStyle(.main)
            
            Spacer()
        } .padding(.leading, 16)
    }
    
    // MARK: - 이미지 6개 컴포넌트
    @ViewBuilder
    func imageVGrid() -> some View {
        HStack {
            LazyVGrid(columns: columns) {
                ForEach(combinedImage.indices, id: \.self) { index in
                    GuideImageComponent(num: index + 1, selectedImage: combinedImage[index])
                }
            }
        }
    }
    
    private func screenShot() {
            let screenshot = body.takeScreenshot(origin: UIScreen.main.bounds.origin, size: UIScreen.main.bounds.size)
            UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
            
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    DispatchQueue.main.async {
                        showingAlert = true
                    }
                case .denied, .restricted, .notDetermined, .limited:
                    break
                @unknown default:
                    break
                }
            }
        }



        private func share() {
            let screenshot = body.takeScreenshot(origin: UIScreen.main.bounds.origin, size: UIScreen.main.bounds.size)
            let activityViewController = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
            
            if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
                rootViewController.present(activityViewController, animated: true, completion: nil)
            }
        }





        private func checkPhotoPermission(completion: @escaping (Bool) -> Void) {
               var status: PHAuthorizationStatus = .notDetermined
               if #available(iOS 14, *) {
                   status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
               } else {
                   status = PHPhotoLibrary.authorizationStatus()
               }
        
               if status == .notDetermined {
                   PHPhotoLibrary.requestAuthorization { newStatus in
                       completion(newStatus == .denied)
                   }
               } else {
                   completion(status == .denied)
               }
           }
    
}
