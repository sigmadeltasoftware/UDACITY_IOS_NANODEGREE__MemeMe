//
//  Toolbar.swift
//  MemeMe
//
//  Created by Bojan Belic on 23/11/2020.
//

import SwiftUI

struct Toolbar: ToolbarContent {
    
    private let CAMERA_ICON = "camera"
    private let SHARE_ICON = "square.and.arrow.up"
    
    var onAlbumClicked: () -> Void
    var onCameraClicked: () -> Void
    var onShareClicked: () -> Void
    var onCancelClicked: () -> Void
    var isShareEnabled: Bool
    
    private let ALBUM_TAG = "Album"
    private let CANCEL_TAG = "Cancel"
    
    var body: some ToolbarContent {
        
        // Top Bar
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
                onShareClicked()
            }) {
                Image(systemName: SHARE_ICON)
            }
            .disabled(!isShareEnabled)
        }
        
        ToolbarItem(placement: .primaryAction) {
            Button(CANCEL_TAG) {
                onCancelClicked()
            }
        }
        
        // BottomBar
        ToolbarItem(placement: .bottomBar) {
            Spacer()
        }
        
        ToolbarItem(placement: .bottomBar) {
            Button(action: {
                onCameraClicked()
            }) {
                Image(systemName: CAMERA_ICON)
            }
            
        }
        
        ToolbarItem(placement: .bottomBar) {
            Spacer()
        }
            
        ToolbarItem(placement: .bottomBar) {
            Button(ALBUM_TAG) {
                onAlbumClicked()
            }
        }
        
        ToolbarItem(placement: .bottomBar) {
            Spacer()
        }
    }
}
