//
//  ImageSave.swift
//  Sgrr
//
//  Created by Evelyn Hong on 8/4/24.
//

import SwiftUI
import Photos

//권한 체크
private func checkPhotoPermission() -> Bool {
    var status: PHAuthorizationStatus = .notDetermined
    if #available(iOS 14, *) {
        status = PHPhotoLibrary.authorizationStatus(for: .addOnly)} else {
            status = PHPhotoLibrary.authorizationStatus()
        }
    return status == .denied
}

struct ViewCoontroller: View {
    // MARK: Property
    @State private var showingAlert: Bool = false
    
    // MARK: View
    var body: some View {
        VStack {
        }
    }
}

#Preview {
    ViewCoontroller()
}
