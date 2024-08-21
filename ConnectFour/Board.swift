//
//  Board.swift
//  ConnectFour
//
//  Created by Yasemin Khanmoradi on 2024-08-19.
//

import Foundation
import UIKit

//2D array to represent the Connect Four board
var board = [[BoardItem]]()

//Reset the board to its initial empty state
func resetBoard() {
    board.removeAll()   //Clear the current board
    
    //Populate the board with empty tiles
    for row in 0...5 {
        var rowArray = [BoardItem]()
        for column in 0...6 {
            let indexPath = IndexPath(item: column, section: row)
            let boardItem = BoardItem(indexPath: indexPath, tile: Tile.Empty)
            rowArray.append(boardItem)
        }
        board.append(rowArray)
    }
}

//Retrieve a specific BoardItem using its index path
func getBoardItem(_ indexPath: IndexPath) -> BoardItem {
    return board[indexPath.section][indexPath.item]
}

//Get the lowest empty tile in a specific column
func getLowestEmptyBoardItem(_ column: Int) -> BoardItem? {
    //Iterate from the bottom row up
    for row in (0...5).reversed() {
        let boardItem = board[row][column]
        if boardItem.emptyTile() {
            return boardItem
        }
    }
    return nil //Return nil if the column is full
}

//Update the board with a new BoardItem state
func updateBoardWithBoardItem(_ boardItem: BoardItem) {
    if let indexPath = boardItem.indexPath {
        board[indexPath.section][indexPath.item] = boardItem
    }
}

//Check if the board is full with no empty spaces
func boardIsFull() -> Bool {
    for row in board {
        for column in row {
            if column.emptyTile() {
                return false    //Board is not full
            }
        }
    }
    return true //Board is full
}

//Check if a victory condition has been achieved
func victoryAchieved() -> Bool {
    return horizontalVictory() || verticalVictory() || diagonalVictory()
}

//Check for a diagonal victory (in any direction)
func diagonalVictory() -> Bool {
    for column in 0...board.count {
        if checkDiagonalColumn(column, true, true) {
            return true
        }
        if checkDiagonalColumn(column, true, false) {
            return true
        }
        if checkDiagonalColumn(column, false, true) {
            return true
        }
        if checkDiagonalColumn(column, false, false) {
            return true
        }
    }
    return false
}

//Helper function to check diagonal victories in specific directions
func checkDiagonalColumn(_ columnToCheck: Int, _ moveUp: Bool, _ reverseRows: Bool) -> Bool {
    var movingColumn = columnToCheck
    var consecutive = 0
    
    if reverseRows {
        //Check diagonals from bottom to top
        for row in board.reversed() {
            if movingColumn < row.count && movingColumn >= 0 {
                if row[movingColumn].tile == currentTurnTile() {
                    consecutive += 1
                    if consecutive >= 4 {
                        return true
                    }
                } else {
                    consecutive = 0
                }
                movingColumn = moveUp ? movingColumn + 1 : movingColumn - 1
            }
        }
    } else {
        //Check diagonals from top to bottom
        for row in board {
            if movingColumn < row.count && movingColumn >= 0 {
                if row[movingColumn].tile == currentTurnTile() {
                    consecutive += 1
                    if consecutive >= 4 {
                        return true
                    }
                } else {
                    consecutive = 0
                }
                movingColumn = moveUp ? movingColumn + 1 : movingColumn - 1
            }
        }
    }
    return false
}

//Check for a horizontal victory
func horizontalVictory() -> Bool {
    for row in board {
        var consecutive = 0
        for column in row {
            if column.tile == currentTurnTile() {
                consecutive += 1
                if consecutive >= 4 {
                    return true
                }
            } else {
                consecutive = 0
            }
        }
    }
    return false
}

//Check for a vertical victory
func verticalVictory() -> Bool {
    for column in 0...board.count {
        var consecutive = 0
        for row in board {
            if row[column].tile == currentTurnTile() {
                consecutive += 1
                if consecutive >= 4 {
                    return true
                }
            } else {
                consecutive = 0
            }
        }
    }
    return false
}
