//
//  RoundWinnerViewController.swift
//  HotPhone
//
//  Created by Ashley Smith on 1/13/22.
//

import UIKit

class RoundWinnerViewController: UIViewController {
    
    let gameManager = GameManager()
    
    @IBOutlet weak var team1: UILabel!
    @IBOutlet weak var team2: UILabel!
    @IBOutlet weak var team1Plus: UIButton!
    @IBOutlet weak var team1Minus: UIButton!
    @IBOutlet weak var team2Plus: UIButton!
    @IBOutlet weak var team2Minus: UIButton!
    
    override func viewDidLoad() {
        showScore()
        team1Minus.isEnabled = false
        team2Minus.isEnabled = false
        self.navigationItem.hidesBackButton = true
    }
  
    @IBAction func nextRoundPressed(_ sender: Any) {
        nextRound()
    }
    
    //MARK: - Round Winner Selected Method
    
    @IBAction func roundWinnerSelected(_ sender: UIButton) {
        if sender == team1Plus {
            gameManager.team1Score += 1
            showScore()
            gameManager.setTeam1Score()
            team1Plus.isEnabled = false
            team1Minus.isEnabled = true
        } else if sender == team2Plus {
            gameManager.team2Score += 1
            showScore()
            gameManager.setTeam2Score()
            team2Plus.isEnabled = false
            team2Minus.isEnabled = true
        } else if sender == team1Minus {
            gameManager.team1Score -= 1
            showScore()
            gameManager.setTeam1Score()
            team1Plus.isEnabled = true
            team1Minus.isEnabled = false
        } else if sender == team2Minus {
            gameManager.team2Score -= 1
            showScore()
            gameManager.setTeam2Score()
            team2Plus.isEnabled = true
            team2Minus.isEnabled = false
        }
    }
        
    //MARK: - Show Score Method
    
    func showScore() {
        team1.text = "\(gameManager.team1Score)"
        team2.text = "\(gameManager.team2Score)"
    }
    
//MARK: - Update Round Number Method
    
    func nextRound() {
        gameManager.gameRound += 1
        gameManager.setGameRound()
        if gameManager.gameRound > 7 {
            gameOver()
        } else {
            goToCategories()
        }
    }
    
//MARK: - Go To Game Over VC
    
    func gameOver() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.goToGameOverVC, sender: self)
        }
    }
    
//MARK: - Go To Category VC
    
    func goToCategories() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.goToCategoryVC, sender: self)
        }
    }
}

    


            
