//
//  GameViewController.swift
//  HotPhone
//
//  Created by Ashley Smith on 1/12/22.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    let wordArray = Words()
    let gameManager = GameManager()
    var player = AVAudioPlayer()
    var timer = Timer()
    var words = [String]()
    var timerLength = Double()
    var secondsPassed = 0.0
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLength = gameManager.roundTime()
        gameManager.playSound(soundName: "\(timerLength)")
        updateUI()
        progressBar.progress = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(goToRoundWinner), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.stop()
        timer.invalidate()
    }
    
//MARK: - Update Game UI
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
    
    func updateUI() {
        let currentWord = words.randomElement()
        if let index = words.firstIndex(of: currentWord ?? "")  {
          words.remove(at: index)
        }
        wordLabel.text = currentWord
    }
    
//MARK: - Go To Round Winner VC
  
    @objc func goToRoundWinner() {
        let totalTime = timerLength
     
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            nextButton.isEnabled = false
            wordLabel.text = K.endOfRound
           
            DispatchQueue.main.asyncAfter(deadline:.now() + 1.0, execute: {
                self.performSegue(withIdentifier: K.gotoRoundWinnerVC,sender: self)
            })
        }
    }
}

