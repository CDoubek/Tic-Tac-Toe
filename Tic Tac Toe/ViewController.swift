//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Student on 1/12/21.
//  Copyright © 2021 Echo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var gridLabel0: GridLabel!
    @IBOutlet weak var gridLabel1: GridLabel!
    @IBOutlet weak var gridLabel2: GridLabel!
    @IBOutlet weak var gridLabel3: GridLabel!
    @IBOutlet weak var gridLabel4: GridLabel!
    @IBOutlet weak var gridLabel5: GridLabel!
    @IBOutlet weak var gridLabel6: GridLabel!
    @IBOutlet weak var gridLabel7: GridLabel!
    @IBOutlet weak var gridLabel8: GridLabel!
    var labelArray = [GridLabel]()
    
    var xTurn = true
    var gameOver = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelArray.append(gridLabel0)
        labelArray.append(gridLabel1)
        labelArray.append(gridLabel2)
        labelArray.append(gridLabel3)
        labelArray.append(gridLabel4)
        labelArray.append(gridLabel5)
        labelArray.append(gridLabel6)
        labelArray.append(gridLabel7)
        labelArray.append(gridLabel8)
    }
    @IBAction func onTappedGridLabel(_ sender: UITapGestureRecognizer) {
        if gameOver {
            return
        }
        var canPlay = false
        for label in labelArray{
            if label.frame.contains(sender.location(in: backgroundView)) {
                if label.canTap  {
                    if xTurn {
                        label.text = "X"
                    }
                    else {
                        label.text = "O"
                    }
                    xTurn = !xTurn
                    label.canTap = false
                    checkForWinner()
                }
            }
            if label.canTap {
                canPlay = true
            }
        }
        if !canPlay && !gameOver {
            displayWinningMessage(message: "Cats Game")
        }
    }
    
    func checkForWinner() {
        //check the top row
        checkLine(a: 0, b: 1, c: 2)
        
        //check the middle row
        checkLine(a: 3, b: 4, c: 5)
        
        //check the bottom row
        checkLine(a: 6, b: 7, c: 8)
        
        //check the left column
        checkLine(a: 0, b: 3, c: 6)
        
        //check the middle column
        checkLine(a: 1, b: 4, c: 7)
        
        //check the right column
        checkLine(a: 2, b: 5, c: 8)
        
        //check left diagonal
        checkLine(a: 0, b: 4, c: 8)
        
        //check right diagonal
        checkLine(a: 2, b: 4, c: 6)
    }
    
    func checkLine(a: Int, b: Int, c: Int) {
        if (labelArray[a].text != "" &&
            labelArray[a].text == labelArray[b].text &&
            labelArray[b].text == labelArray[c].text) {
            displayWinningMessage(message: "\(labelArray[a].text!) is the winner!")
        }
    }
    
    func displayWinningMessage(message:String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Reset", style: .default) {
            (action) -> Void in self.resetGame()
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        gameOver = true
    }
    
    func resetGame() {
        for label in labelArray{
            label.text = ""
            label.canTap = true
        }
        xTurn = true
        gameOver = false
    }
}
