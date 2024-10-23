//
//  ContentView.swift
//  PowerPlayWatchApp Watch App
//
//  Created by Abhishek Suryawanshi on 20/10/24.
//

import SwiftUI

struct WatchGameView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        VStack(spacing: 0) {
            
            ScoreHeaderView()
            
            GeometryReader { geometry in
                VStack {
                    let spacing: CGFloat = 5
                    let numRows = 3
                    let numCols = 3
                    
                    // Define the available space only for the grid view
                    let availableWidth = geometry.size.width
                    let availableHeight = geometry.size.height
                    let tileSize = min(availableWidth / CGFloat(numCols), availableHeight / CGFloat(numRows))
                    
                    let columns = Array(repeating: GridItem(.fixed(tileSize), spacing: spacing), count: numCols)
                    
                    LazyVGrid(columns: columns, spacing: spacing) {
                        ForEach(0..<numRows, id: \.self) { row in
                            ForEach(0..<numCols, id: \.self) { col in
                                let tile = gameManager.grid[row][col]
                                TileView(tile: tile, onActivatePowerUp: {
                                    // Activate the power-up when clicked
                                    gameManager.activatePowerUp(at: row, col: col)
                                })
                                .frame(width: tileSize, height: tileSize)
                            }
                        }
                    }
                    .cornerRadius(8)
                    .gesture(
                        DragGesture()
                            .onEnded { gesture in
                                let horizontalAmount = gesture.translation.width
                                let verticalAmount = gesture.translation.height
                                
                                if abs(horizontalAmount) > abs(verticalAmount) {
                                    if horizontalAmount > 0 {
                                        gameManager.swipe(direction: .right)
                                    } else {
                                        gameManager.swipe(direction: .left)
                                    }
                                } else {
                                    if verticalAmount > 0 {
                                        gameManager.swipe(direction: .down)
                                    } else {
                                        gameManager.swipe(direction: .up)
                                    }
                                }
                            }
                    )
                    .focusable()
                    .digitalCrownRotation($gameManager.crownOffset, from: -1, through: 1, by: 0.1)
                    .onChange(of: gameManager.crownOffset) { value in
                        if value > 0 {
                            gameManager.swipe(direction: .down)
                        } else {
                            gameManager.swipe(direction: .up)
                        }
                    }
                }
            }
            .background(Color(red: 0.78, green: 0.73, blue: 0.68))
        }
    }
}

#Preview {
    // Create a sample GameManager with some test data
    let previewGameManager = GameManager()
    previewGameManager.currentScore = previewGameManager.currentScore ?? 0
    previewGameManager.bestScore = previewGameManager.bestScore ?? 0
    
    // Return the WatchGameView with the preview GameManager
    return WatchGameView()
        .environmentObject(previewGameManager) // Inject the GameManager
}
