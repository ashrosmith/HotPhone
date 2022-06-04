//
//  GameManager.swift
//  HotPhone
//
//  Created by Ashley Smith on 5/11/22.
//

import UIKit
import AVFoundation

public class GameManager {
    
    var team1Score = UserDefaults.standard.integer(forKey: K.team1Score)
    var team2Score = UserDefaults.standard.integer(forKey: K.team2Score)
    var gameRound = UserDefaults.standard.integer(forKey: K.gameRound)
    var hasRun = UserDefaults.standard.integer(forKey: K.hasRun)
    var timeArray: [Double] = [34.7, 39.72, 44.74, 48.03, 49.78, 54.37, 60.06]
    var player = AVAudioPlayer()
    
    func setTeam1Score() {
        UserDefaults.standard.set(team1Score, forKey: K.team1Score)
    }

    func setTeam2Score() {
        UserDefaults.standard.set(team2Score, forKey: K.team2Score)
    }
    
    func setGameRound() {
        UserDefaults.standard.set(gameRound, forKey: K.gameRound)
    }
    
    func reset() {
        gameRound = 1
        team1Score = 0
        team2Score = 0
        setGameRound()
        setTeam1Score()
        setTeam2Score()
    }
    
   func roundTime() -> Double {
       let time = timeArray.randomElement() ?? 60.06
       return time
    }
    
    func playSound(soundName: String) {
         let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
         player = try! AVAudioPlayer(contentsOf: url!)
         player.play()
     }
    
    func appAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
       
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = Colors.orange
        alert.view.tintColor = Colors.purple
        alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy), NSAttributedString.Key.foregroundColor : Colors.purple]), forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16,weight: UIFont.Weight.regular),NSAttributedString.Key.foregroundColor : Colors.blue]), forKey: "attributedMessage")
        
        alert.addAction(okAction)
        viewController.present(alert, animated: true)
    }
    
    func isPurchased() -> Bool {
        
        let purchaseStatus = UserDefaults.standard.bool(forKey: K.productID)
        
        if purchaseStatus {
            return true
        } else {
            return false
        }
    }
}
