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
    
    func playGameAlert() {
        let alert = UIAlertController(title: "Ready to play?", message: "If you need to refer back to the rules, they can always be found under settings.", preferredStyle: .alert)
        
        let playAction = UIAlertAction(title: "Play", style: .default) { (action) in
            self.performSegue(withIdentifier: K.playGame, sender: self)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = Colors.orange
        alert.view.tintColor = Colors.purple
        alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy), NSAttributedString.Key.foregroundColor : Colors.purple]), forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16,weight: UIFont.Weight.regular),NSAttributedString.Key.foregroundColor : Colors.blue]), forKey: "attributedMessage")
        
        alert.addAction(playAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

}
