//
//  BoardItem.swift
//  ConnectFour
//
//  Created by Yasemin Khanmoradi on 2024-08-19.
//

import Foundation
import UIKit

//Enum to represent the state of each tile on the board
enum Tile {
    case Yellow
    case Pink
    case Empty
}

//Struct to represent each item on the Connect Four board
struct BoardItem {
    var indexPath: IndexPath!   //The position of the item in the collection view
    var tile: Tile! //The current state of the tile (Yellow, Pink, or Empty)
    
    //Check if the tile is Yellow
    func yellowTile() -> Bool {
        return tile == Tile.Yellow
    }
    
    //Check if the tile is Pink
    func pinkTile() -> Bool {
        return tile == Tile.Pink
    }
    
    //Check if the tile is Empty
    func emptyTile() -> Bool {
        return tile == Tile.Empty
    }
    
    //Return the color associated with the current tile state
    func tileColor() -> UIColor {
        if yellowTile() {
            return .systemYellow
        }
        if pinkTile() {
            return .systemPink
        }
        return .white   //Return white color for Empty tiles
    }
}
