//
//  RulesViewController.swift
//  HotPhone
//
//  Created by Ashley Smith on 5/31/22.
//

import UIKit

class RulesViewController: UIViewController {
    
    let gameManager = GameManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func playGamePressed(_ sender: UIButton) {
        playGameAlert()
    }
    
    private func playGameAlert() {
        let alert = UIAlertController(title: "Ready to play?", message: "If you need to refer back to the rules, they can always be found under settings.", preferredStyle: .alert)
        
        let playAction = UIAlertAction(title: "Play", style: .default) { (action) in
            self.performSegue(withIdentifier: K.playGame, sender: self)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        gameManager.alertDesign(alert: alert)
        alert.addAction(playAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

}
