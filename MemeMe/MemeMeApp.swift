//
//  MemeMeApp.swift
//  MemeMe
//
//  Created by Bojan Belic on 23/11/2020.
//

import SwiftUI

@main
struct MemeMeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .navigationBarTitle("", displayMode: .inline)
                    
                logD("Starting MemeMe...")
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
