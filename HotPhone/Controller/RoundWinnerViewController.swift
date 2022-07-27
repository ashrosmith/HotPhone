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
        self.navigationItem.hidesBackButton = true
    }
  
    @IBAction func nextRoundPressed(_ sender: UIButton) {
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
            if gameManager.team1Score > 0 {
            gameManager.team1Score -= 1
            showScore()
            gameManager.setTeam1Score()
            team1Plus.isEnabled = true
            team1Minus.isEnabled = false
            } else {
                gameManager.team1Score = 0
            }
        } else if sender == team2Minus {
            if gameManager.team2Score > 0 {
            gameManager.team2Score -= 1
            showScore()
            gameManager.setTeam2Score()
            team2Plus.isEnabled = true
            team2Minus.isEnabled = false
            } else {
                gameManager.team2Score = 0
            }
        }
    }
        
    //MARK: - Show Score Method
    
    private func showScore() {
        team1.text = "\(gameManager.team1Score)"
        team2.text = "\(gameManager.team2Score)"
    }
    
//MARK: - Update Round Number Method
    
    private func nextRound() {
        gameManager.gameRound += 1
        gameManager.setGameRound()
        if gameManager.gameRound > 7 {
            gameOver()
        } else {
            goToCategories()
        }
    }
    
//MARK: - Go To Game Over VC
    
    private func gameOver() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.goToGameOverVC, sender: self)
        }
    }
    
//MARK: - Go To Category VC
    
   private func goToCategories() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.goToCategoryVC, sender: self)
        }
    }
}

    


            
