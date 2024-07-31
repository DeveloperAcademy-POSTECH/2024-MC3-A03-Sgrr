//
//  CakeCanvasView_test.swift
//  Sgrr
//
//  Created by dora on 7/30/24.
//

import SwiftUI
import PencilKit

struct CakeCanvasView_test: View {
    let palette = PKToolPicker()
 
    @State private var canvasView = PKCanvasView()
    @State var showPhotoPalette: Bool = true
   
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {}){
                    Image(systemName: "chevron.backward")
                }
                
                Spacer()
                
                Button(action: {
                    palette.setVisible(true, forFirstResponder: canvasView)
                    showPhotoPalette = false
                    
                }){
                    Image(systemName:"applepencil.tip")
                }
                
                Button(action: {
                    palette.setVisible(false, forFirstResponder: canvasView)
                    showPhotoPalette = true
                    
                }){
                    Image(systemName:"photo")
                }
            }.padding().background(.placeholder)
            
            ZStack{
                CanvasViewContainer(canvasView: $canvasView, palette: palette)
                    .onAppear{
                        ///photoPaletteCell에 fetch 하는 로직
                        palette.setVisible(false, forFirstResponder: canvasView)
                        palette.addObserver(canvasView)
                        canvasView.becomeFirstResponder()
                        
                    }
                if(showPhotoPalette){
                    VStack{
                        Spacer()
                        let indexs = Array(0..<5)
                        
                            HStack {
                                ForEach(indexs, id: \.self) { index in
                                    
                                    Button(action:{
                                        addPhoto( UIImage(imageLiteralResourceName: "cakeElement_" + "\(index + 1)"))
                                        print("버튼 누름!")
                                    } ){
                                        ZStack {
                                            Rectangle()
                                            /// ✅ 담겨있는 거 가져와야함!
                                            Image("cakeElement_" + "\(index + 1)")
                                                .resizable()
                                                .padding(5)
                                        }
                                        .frame(width: 67, height: 67)
                                    }
                                   
                                }
                            }
                    }
                    .background(.clear)
                    .animation(.easeInOut)
                    .transition(.move(edge: .bottom))
                }
            }
                
        }
        
        
    }
    
    func addPhoto(_ image: UIImage){
        var cnt: Int = 0
       
        print("addPhoto")
        
        DispatchQueue.main.async {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: 200 + cnt, height: 200)
            /// 비율 맞춰서 크기 줄임
            imageView.contentMode = .scaleAspectFit
            
            /// pkcanvas view를 위에 쌓기!
            self.canvasView.addSubview(imageView)
        }
        cnt = cnt + 200
        
    }
    
    
    /// 그린 것 SwiftUI에 담기 위한 컨테이너
    struct CanvasViewContainer: UIViewRepresentable {
        @Binding var canvasView: PKCanvasView
        
        let palette: PKToolPicker
        
        func makeUIView(context: Context) -> some UIView {
            canvasView.backgroundColor = .clear
            canvasView.tool = PKInkingTool(.pen, color: .blue, width: 15)
            
            return canvasView
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            uiView.backgroundColor = .clear
        }
        
    }
}

#Preview {
    CakeCanvasView_test()
}
 
