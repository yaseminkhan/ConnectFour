//
//  Turn.swift
//  ConnectFour
//
//  Created by Yasemin Khanmoradi on 2024-08-19.
//

import Foundation
import UIKit

enum Turn {
    case Orange
    case Purple
}

var currentTurn = Turn.Orange

func toggleTurn(_ turnImage: UIImageView){
    if orangeTurn(){
        currentTurn = Turn.Purple
        turnImage.tintColor = .purple
    } else {
        currentTurn = Turn.Orange
        turnImage.tintColor = .systemOrange
    }
}

func orangeTurn() -> Bool {
    return currentTurn == Turn.Orange
}

func purpleTurn() -> Bool {
    return currentTurn == Turn.Purple
}

func currentTurnTile() -> Tile {
    return orangeTurn() ? Tile.Orange : Tile.Purple
}

func currentTurnColour() -> UIColor {
    return orangeTurn() ? .systemOrange : .purple
}

func currentTurnVictoryMessage() -> String {
    return orangeTurn() ? "Orange Wins!" : "Purple Wins!"
}

