//
//  PowerPlayWatchAppApp.swift
//  PowerPlayWatchApp Watch App
//
//  Created by Abhishek Suryawanshi on 20/10/24.
//

import SwiftUI

@main
struct PowerPlayWatchApp_Watch_AppApp: App {
    @StateObject private var gameManager = GameManager() // Create the GameManager instance
    
    var body: some Scene {
        WindowGroup {
            WatchGameView() // Pass it to the WatchGameView
                .environmentObject(gameManager) // Inject the GameManager
        }
    }
}
