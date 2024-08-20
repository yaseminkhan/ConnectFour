//
//  ViewController.swift
//  ConnectFour
//
//  Created by Yasemin Khanmoradi on 2024-08-19.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var orangeScore = 0
    var purpleScore = 0

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var turnImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBoard()
        setCellWidthHeight()
    }
    
    func setCellWidthHeight(){
        let width = collectionView.frame.size.width / 9
        let height = collectionView.frame.size.height / 6
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
        
        let horizontalInsect = 3.5
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: horizontalInsect, bottom: 0, right: horizontalInsect)
        
    }
    func numberOfSections(in cv: UICollectionView) -> Int {
        return board.count
    }
    
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return board[section].count
    }
    
    func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! BoardCell
        
        let boardItem = getBoardItem(indexPath)
        cell.image.tintColor = boardItem.tileColor()
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let column = indexPath.item
        if var boardItem = getLowestEmptyBoardItem(column){
            if let cell = collectionView.cellForItem(at: boardItem.indexPath) as? BoardCell {
                cell.image.tintColor = currentTurnColour()
                boardItem.tile = currentTurnTile()
                updateBoardWithBoardItem(boardItem)
                
                if victoryAchieved(){
                    if orangeTurn(){
                        orangeScore+=1
                    }
                    if purpleTurn(){
                        purpleScore+=1
                    }
                    resultAlert(currentTurnVictoryMessage())
                }
                
                if boardIsFull() {
                    resultAlert("Draw")
                }
                toggleTurn(turnImage)
            }
        }
    }
    
    func resultAlert(_ title: String){
        let message = "\nOrange: " + String(orangeScore) + "\n\nPurple: " + String(purpleScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: {
            [self] (_) in
            resetBoard()
            resetCells()
        }))
        self.present(ac, animated: true)
    }
    
    func resetCells(){
        for cell in collectionView.visibleCells as! [BoardCell]{
            cell.image.tintColor = .white
        }
    }

}

