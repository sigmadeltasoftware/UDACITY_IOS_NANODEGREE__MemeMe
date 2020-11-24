//
//  ContentView.swift
//  MemeMe
//
//  Created by Bojan Belic on 23/11/2020.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State private var activeSheet: SheetType? = nil
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var isShareEnabled = false
    
    @State private var originalImage = UIImage()
    @State private var image = UIImage()
    @State private var topText: String = Constants.topTextDefault
    @State private var bottomText: String = Constants.bottomTextDefault
    
    @State var meme: Meme! = nil
    
    var body: some View {
        let img = Image(uiImage: originalImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .background(Color.black)
            .overlay(TextOverlay(text: $topText), alignment: .top)
            .overlay(TextOverlay(text: $bottomText), alignment: .bottom)
        
        img.toolbar {
            Toolbar(
                onAlbumClicked: {
                    sourceType = .photoLibrary
                    activeSheet = .picker
                    logD("onAlbumClicked()")
                },
                onCameraClicked: {
                    sourceType = .camera
                    activeSheet = .picker
                    logD("onCameraClicked()")
                },
                onShareClicked: {
                    logD("onShareClicked()")
                    activeSheet = .share
                },
                onCancelClicked: {
                    logD("onCancelClicked()")
                    resetUi()
                },
                isShareEnabled: isShareEnabled
            )
        }
        .sheet(item: $activeSheet.onChange(perform: { (new, old) in
            if new == SheetType.share {
                image = img.asUIImage()
                meme = createMeme()
            }
        })) { item in
            switch item {
                case .picker: ImagePicker(sourceType: sourceType,
                                          imagePickerDelegate: ImagePickerDelegate(
                                              onDismiss: {
                                                  logD("onDismiss()")
                                                  activeSheet = nil
                                              },
                                              onImagePicked: { image in
                                                  logD("onImagePicked(): \(image)")
                                                  originalImage = image
                                                  isShareEnabled = true
                                              }
                                          )
                                      )
                
                case .share: ActivityView(activityItems: [image]) {
                    logD("onDismiss()")
                    activeSheet = nil
                }
            }
        }
    }

    // This method is here to comply with the specifications for this project, otherwise there is no practical
    // use for it at the moment
    private func createMeme() -> Meme {
        return Meme(TopText: topText, bottomText: bottomText, originalImage: originalImage, modifiedImage: image)
    }
    
    private func resetUi() {
        isShareEnabled = false
        topText = Constants.topTextDefault
        bottomText = Constants.bottomTextDefault
        originalImage = UIImage()
    }
}

enum SheetType: Identifiable {
    case picker, share
    
    var id: Int {
        hashValue
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
