//
//  TileView.swift
//  PowerPlayWatchApp Watch App
//
//  Created by Abhishek Suryawanshi on 20/10/24.
//

import SwiftUI

struct TileView: View {
    var tile: Tile
    var onActivatePowerUp: (() -> Void)? // Callback to trigger when power-up tile is tapped
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(tileBackgroundColor)
                .aspectRatio(1, contentMode: .fit)
                .onTapGesture {
                    // Detect if the tile is a power-up and activate it
                    if case .powerUp = tile.content {
                        print("power-up tile pressed")
                        onActivatePowerUp?() // Call the power-up activation callback
                    }
                }
            
            if case let .number(value) = tile.content, value > 0 {
                Text("\(value)")
                    .font(.system(size: 16)) // Adjusted for watch size
                    .bold()
                    .foregroundColor(textColor(for: value))
            } else if case .powerUp(let powerUp) = tile.content {
                powerUpView(for: powerUp)
            }
        }
    }
    
    private func textColor(for value: Int) -> Color {
        switch value {
        case 2, 4:
            return Color.black
        default:
            return Color.white
        }
    }
    
    private var tileBackgroundColor: Color {
        switch tile.content {
        case .number(let value):
            switch value {
            case 0:
                return .gray // Empty tile
            case 2:
                return Color(red: 0.93, green: 0.89, blue: 0.85)
            case 4:
                return Color(red: 0.93, green: 0.88, blue: 0.78)
            case 8:
                return Color(red: 0.95, green: 0.69, blue: 0.47)
            case 16:
                return Color(red: 0.96, green: 0.58, blue: 0.39)
            case 32:
                return Color(red: 0.96, green: 0.48, blue: 0.37)
            case 64:
                return Color(red: 0.96, green: 0.35, blue: 0.23)
            default:
                return Color(red: 0.93, green: 0.76, blue: 0.61)
            }
        case .powerUp:
            return Color.red
        }
    }
    
    @ViewBuilder
    func powerUpView(for powerUp: PowerUp) -> some View {
        switch powerUp {
        case .clearRow:
            Image(systemName: "rectangle.grid.1x2.fill")
        case .clearColumn:
            Image(systemName: "rectangle.grid.2x1.fill")
        case .doubleTile:
            Image(systemName: "plus.square.fill")
        }
    }
}
