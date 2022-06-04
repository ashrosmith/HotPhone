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
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = Colors.orange
        alert.view.tintColor = Colors.purple
        alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy), NSAttributedString.Key.foregroundColor : Colors.purple]), forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16,weight: UIFont.Weight.regular),NSAttributedString.Key.foregroundColor : Colors.blue]), forKey: "attributedMessage")
        
        alert.addAction(resetAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
    }
    
    
    @IBAction func rateAppPressed(_ sender: UIButton) {
        rateApp(id: K.appID)
    }
    
    @IBAction func restorePurchasesPressed(_ sender: UIButton) {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    @IBAction func rulesPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.goToRulesVC, sender: self)
        }
    }
    
    func rateApp(id : String) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/id\(id)?mt=8&action=write-review") else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
