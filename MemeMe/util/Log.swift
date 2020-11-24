//
//  Log.swift
//  MemeMe
//
//  Created by Bojan Belic on 23/11/2020.
//

import SwiftUI

@discardableResult func logD(_ msg: String) -> EmptyView {
    #if DEBUG
    print("*DEBUG* \(msg)")
    #endif
    return EmptyView()
}
