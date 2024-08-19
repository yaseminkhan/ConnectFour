//
//  BoardItem.swift
//  ConnectFour
//
//  Created by Yasemin Khanmoradi on 2024-08-19.
//

import Foundation
import UIKit

enum Tile{
    case Orange
    case Purple
    case Empty
}

struct BoardItem{
    var indexPath: IndexPath!
    var tile: Tile!
    
    func orangeTile() -> Bool {
        return tile == Tile.Orange
    }
    func purpleTile() -> Bool {
        return tile == Tile.Purple
    }
    func emptyTile() -> Bool {
        return tile == Tile.Empty
    }
    
    func tileColor() -> UIColor{
        if orangeTile(){
            return .systemOrange
        }
        if purpleTile(){
            return .purple
        }
        return .white
    }
}
