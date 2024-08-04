////
////  OrderFormView.swift
////  Sgrr
////
////  Created by KIM SEOWOO on 7/26/24.
////
//
//import SwiftUI
//
//struct OrderFormView: View {
//    @EnvironmentObject var router: Router
//
//
//    var body: some View {
//        
//        GeometryReader { geo in
//            ZStack {
//                ScrollView {
//                    LazyVStack {
//                        VStack {
//                            ColorView()
//                        } .frame(height: geo.size.height)
//                        VStack {
//                            ConceptView()
//                        } .frame(height: geo.size.height)
//                        VStack {
//                            ComponentView()
//                        } .frame(height: geo.size.height)
//                    }
//                    
//                }
//                .scrollTargetBehavior(.paging)
//                .foregroundStyle(.background)
//                .background(Color.bg)
//                
//                Button {
//                    // 작성 완료하기
//                    saveOrder()
//                    router.push(view: .FinalGuideView)
//                } label: {
//                    RoundedRectangle(cornerRadius: 10)
//                        .foregroundStyle(.main)
//                        .frame(width: 345, height: 50)
//                        .overlay() {
//                            Text("작성 완료")
//                                .foregroundColor(.white)
//                                .fontWeight(.bold)
//                        }
//                }
//                .padding(.top, 680)
//            }
//        }
//        .toolbarBackground(Color(hex: "F9F6EB"), for: .navigationBar)
//        .toolbar {
//            
//            ToolbarItem(placement: .navigationBarLeading) {
//                
//                Button {
//                     // 홈으로 가기
//                    router.backToHome()
//                } label: {
//                 Image(systemName: "chevron.backward")
//                        .foregroundStyle(.main)
//                        .font(.system(size: 20))
//                }
//               
//            }
//
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button {
//                    // 3D 뷰 이동
//                    router.push(view: .Cake3DView)
//                } label: {
//                 Text("3D")
//                        .foregroundStyle(.main)
//                        .font(.system(size: 20))
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//       
//    }
//}
//
//// MARK: - 저장함수
//private func saveOrder() {
//    CoredataManager.shared.saveOrUpdateOrder()
//}
//
//
//#Preview {
//    OrderFormView()
//}
