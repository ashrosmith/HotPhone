//
//  AddWordViewController.swift
//  HotPhone
//
//  Created by Ashley Smith on 2/17/22.
//

import UIKit

class AddWordViewController: UIViewController {
   
    let wordArray = Words()
    let gameManager = GameManager()
 
    @IBOutlet weak var varietyButton: UIButton!
    @IBOutlet weak var popCultureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popCultureButton.isHidden = true
        varietyButton.isHidden = true
        if gameManager.isPurchased() {
            showAllCategories()
        }
    }

//MARK: - Add New Word to Category
    
    @IBAction func categorySelected(_ sender: UIButton) {
        guard let categoryName = sender.titleLabel?.text else {
            gameManager.appAlert(title: "Error", message: "Error selecting a category. Please try again.", viewController: self)
            return
        }
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Word", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add Word", style: .default) { (action) in
            
            if let entry = textField.text {
                switch categoryName {
                    case K.peopleCategory:
                        self.wordArray.people?.append(entry)
                    case K.foodCategory:
                        self.wordArray.food?.append(entry)
                    case K.worldCategory:
                        self.wordArray.world?.append(entry)
                    case K.objectsCategory:
                        self.wordArray.objects?.append(entry)
                    case K.varietyCategory:
                        self.wordArray.variety?.append(entry)
                    case K.popCultureCategory:
                        self.wordArray.popCulture?.append(entry)
                    default:
                        self.gameManager.appAlert(title: "Error", message: "Error adding the word. Please try again.", viewController: self)
                }
            }
            self.wordArray.saveWords()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
        }
        
        gameManager.alertDesign(alert: alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.attributedPlaceholder = NSAttributedString(string: "Enter New Word", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : Colors.blue])
            alertTextField.backgroundColor = Colors.orange
            alertTextField.superview!.superview!.subviews[0].removeFromSuperview()
            alertTextField.superview!.backgroundColor = UIColor.clear
            alertTextField.textColor = Colors.blue
            textField = alertTextField
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func showAllCategories() {
        DispatchQueue.main.async {
            self.popCultureButton.isHidden = false
            self.varietyButton.isHidden = false
        }
    }
}



