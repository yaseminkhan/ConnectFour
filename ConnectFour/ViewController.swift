//
//  ViewController.swift
//  ConnectFour
//
//  Created by Yasemin Khanmoradi on 2024-08-19.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var yellowScore = 0
    var pinkScore = 0

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var turnImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBoard()    //Initialize the game board
        setCellWidthHeight()    //Configure the size of the collection view cells
    }
    
    //Set the width and height of the collection view cells based on the screen size
    func setCellWidthHeight() {
        let rows: CGFloat = 6
        let collectionViewWidth = collectionView.frame.size.width
        let collectionViewHeight = collectionView.frame.size.height
        
        //Adjust the divisor based on the screen width for better layout on different devices
        let divisor: CGFloat
        if collectionViewWidth <= 340 {
            divisor = 7 //Smaller screens like iPhone SE
        } else if collectionViewWidth < 375 {
            divisor = 8 //Slightly larger small screens
        } else {
            divisor = 7 //Standard and larger screens
        }
        
        //Calculate the side insets to add padding on the left and right sides
        let sideInsetRatio: CGFloat = 0.01
        let sideInset = collectionViewWidth * sideInsetRatio
        let totalSideInsets = sideInset * 2
        
        //Calculate the available width and height after applying insets
        let availableWidth = collectionViewWidth - totalSideInsets
        let availableHeight = collectionViewHeight
        
        //Calculate the ideal cell size based on the adjusted divisor
        let cellWidth = availableWidth / divisor
        let cellHeight = availableHeight / rows
        
        //Configure the flow layout with the calculated cell size and insets
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
    }

    //Return the number of sections (rows) in the collection view
    func numberOfSections(in cv: UICollectionView) -> Int {
        return board.count
    }
    
    //Return the number of items (columns) in each section
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board[section].count
    }
    
    //Configure each cell with the appropriate board item
    func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! BoardCell
        
        let boardItem = getBoardItem(indexPath)
        cell.image.tintColor = boardItem.tileColor()    //Set the tile color based on the board state
        
        return cell
    }

    //Handle the event when a cell is tapped
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let column = indexPath.item
        if var boardItem = getLowestEmptyBoardItem(column) {
            if let cell = collectionView.cellForItem(at: boardItem.indexPath) as? BoardCell {
                cell.image.tintColor = currentTurnColour()  //Update the cell color based on the current turn
                boardItem.tile = currentTurnTile()  //Update the board state
                updateBoardWithBoardItem(boardItem)
                
                //Check for victory or draw conditions
                if victoryAchieved() {
                    if yellowTurn() {
                        yellowScore += 1
                    }
                    if pinkTurn() {
                        pinkScore += 1
                    }
                    resultAlert(currentTurnVictoryMessage())    //Show the victory message
                }
                
                if boardIsFull() {
                    resultAlert("Draw") //Show the draw message
                }
                toggleTurn(turnImage)   //Switch to the next player's turn
            }
        }
    }
    
    //Display an alert with the game result and reset option
    func resultAlert(_ title: String) {
        let message = "\nYellow: " + String(yellowScore) + "\n\nPink: " + String(pinkScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: {
            [self] (_) in
            resetBoard()    //Reset the game board
            resetCells()    //Clear the cell colors
        }))
        
        //Configure the alert for iPad popover presentation
        if let popoverController = ac.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(ac, animated: true)
    }
    
    //Reset the colors of all visible cells to white
    func resetCells() {
        for cell in collectionView.visibleCells as! [BoardCell] {
            cell.image.tintColor = .white
        }
    }
}
