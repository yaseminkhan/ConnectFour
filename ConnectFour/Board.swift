//
//  Board.swift
//  ConnectFour
//
//  Created by Yasemin Khanmoradi on 2024-08-19.
//

import Foundation
import UIKit

var board = [[BoardItem]]()

func resetBoard()
{
    board.removeAll()
    
    for row in 0...5{
        var rowArray = [BoardItem]()
        for column in 0...6{
            let indexPath = IndexPath.init(item: column, section: row)
            let boardItem = BoardItem(indexPath: indexPath, tile: Tile.Empty)
            rowArray.append(boardItem)
        }
        board.append(rowArray)
    }
}

func getBoardItem(_ indexPath: IndexPath) -> BoardItem{
    return board[indexPath.section][indexPath.item]
}

func getLowestEmptyBoardItem(_ column: Int) -> BoardItem? {
    for row in (0...5).reversed() {
        let boardItem = board[row][column]
        if boardItem.emptyTile(){
            return boardItem
        }
    }
    return nil
}

func updateBoardWithBoardItem(_ boardItem: BoardItem){
    if let indexPath = boardItem.indexPath{
        board[indexPath.section][indexPath.item] = boardItem
    }
}

func boardIsFull() -> Bool{
    for row in board{
        for column in row{
            if column.emptyTile(){
                return false
            }
        }
    }
    return true 
}

func victoryAchieved() -> Bool{
    return horizontalVictory()
}

func horizontalVictory() -> Bool{
    for row in board{
        var consecutive = 0
        for column in row{
            if column.tile == currentTurnTile(){
                consecutive+=1
                if consecutive >= 4{
                    return true
                }
            }
            else {
                consecutive = 0
            }
        }
    }
    return false
}
