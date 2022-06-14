//
//  SettingsViewController.swift
//  HotPhone
//
//  Created by Ashley Smith on 5/2/22.
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController {

    let gameManager = GameManager()
    let categoryVC = CategoryViewController()
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetGamePressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are you sure?", message: "Scores will reset to 0 and the game will restart at round 1.", preferredStyle: .alert)
        let resetAction = UIAlertAction(title: "Reset", style: .default) { (action) in
            self.gameManager.reset()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        gameManager.alertDesign(alert: alert)
        alert.addAction(resetAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    
    @IBAction func rateAppPressed(_ sender: UIButton) {
        gameManager.rateApp(id: K.appID)
    }
    
    @IBAction func restorePurchasesPressed(_ sender: UIButton) {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    @IBAction func rulesPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.goToRulesVC, sender: self)
        }
    }
}
