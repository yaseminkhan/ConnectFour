//
//  Turn.swift
//  ConnectFour
//
//  Created by Yasemin Khanmoradi on 2024-08-19.
//

import Foundation
import UIKit

//Enum to represent the current player's turn
enum Turn {
    case Yellow
    case Pink
}

var currentTurn = Turn.Yellow   //Track whose turn it is, starting with Yellow

//Toggle the turn between Yellow and Pink and update the turn indicator image
func toggleTurn(_ turnImage: UIImageView) {
    if yellowTurn() {
        currentTurn = Turn.Pink
        turnImage.tintColor = .systemPink
    } else {
        currentTurn = Turn.Yellow
        turnImage.tintColor = .systemYellow
    }
}

//Check if it's Yellow's turn
func yellowTurn() -> Bool {
    return currentTurn == Turn.Yellow
}

//Check if it's Pink's turn
func pinkTurn() -> Bool {
    return currentTurn == Turn.Pink
}

//Return the tile corresponding to the current turn
func currentTurnTile() -> Tile {
    return yellowTurn() ? Tile.Yellow : Tile.Pink
}

//Return the color corresponding to the current turn
func currentTurnColour() -> UIColor {
    return yellowTurn() ? .systemYellow : .systemPink
}

//Return the victory message for the current turn
func currentTurnVictoryMessage() -> String {
    return yellowTurn() ? "Yellow Wins!" : "Pink Wins!"
}
