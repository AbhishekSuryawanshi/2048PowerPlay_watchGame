//
//  ScoreView.swift
//  PowerPlayWatchApp Watch App
//
//  Created by Abhishek Suryawanshi on 20/10/24.
//


import SwiftUI

struct ScoreHeaderView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        HStack {
            Text("BEST: \(gameManager.bestScore)")
                .font(.system(size: 12))
            Text("SCORE: \(gameManager.currentScore)")
                .font(.system(size: 12))
            
            //Reset Button
            Button(action: {
                gameManager.setupGame()
            }) {
                Image(systemName: "arrow.clockwise")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                    .foregroundColor(.blue)
            }
            .frame(width: 30, height: 30)
            .buttonStyle(PlainButtonStyle())
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .background(Color(red: 0.78, green: 0.73, blue: 0.68))
    }
    
}

#Preview {
    // Create a sample GameManager with some test data
    let previewGameManager = GameManager()
    previewGameManager.currentScore = 1500
    previewGameManager.bestScore = 3000
    
    // Return the ScoreHeaderView with the preview GameManager
    return ScoreHeaderView()
        .environmentObject(previewGameManager) // Inject the GameManager
}
