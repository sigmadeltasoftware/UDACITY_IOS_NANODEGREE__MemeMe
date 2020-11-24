//
//  ContentView.swift
//  MemeMe
//
//  Created by Bojan Belic on 23/11/2020.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State private var isShowingPicker = false
    @State private var isShowingCameraAlert = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var image = UIImage()
    @State private var isShareEnabled = false
    
    var body: some View {
        HStack {
            Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
        }
        .toolbar {
            Toolbar(
                onAlbumClicked: {
                    sourceType = .photoLibrary
                    isShowingPicker = true
                    logD("onAlbumClicked()")
                },
                onCameraClicked: {
                    if (!UIImagePickerController.isSourceTypeAvailable(.camera)) {
                        logD("onCameraClicked(): No camera support available! (emulator?)")
                        isShowingCameraAlert = true
                    } else {
                        sourceType = .camera
                        isShowingPicker = true
                        logD("onCameraClicked()")
                    }
                },
                onShareClicked: {
                    
                },
                onCancelClicked: {
                    
                },
                isShareEnabled: isShareEnabled
            )
        }
        .sheet(isPresented: $isShowingPicker) {
                ImagePicker(sourceType: sourceType,
                    imagePickerDelegate: ImagePickerDelegate(
                        onDismiss: {
                            logD("onDismiss()")
                            isShowingPicker = false
                        },
                        onImagePicked: { image in
                            logD("onImagePicked(): \(image)")
                            self.image = image
                            isShareEnabled = true
                        }
                    )
                )
        }
        .alert(isPresented: $isShowingCameraAlert) {
            Alert(title: Text("Camera Support"), message: Text("Your device doesn't support the camera"), dismissButton: .default(Text("Ok")))
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
