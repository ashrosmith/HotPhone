//
//  CategoryViewController.swift
//  HotPhone
//
//  Created by Ashley Smith on 1/14/22.
//

import UIKit
import StoreKit

class CategoryViewController: UIViewController {
    
    let wordArray = Words()
    let gameManager = GameManager()
    var words = [String]()
    var categoryName = String()
    
    @IBOutlet weak var unlockMoreCategoriesButton: UIButton!
    @IBOutlet weak var popCultureButton: UIButton!
    @IBOutlet weak var varietyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popCultureButton.isHidden = true
        varietyButton.isHidden = true
        SKPaymentQueue.default().add(self)
        if gameManager.isPurchased() {
            showAdditionalCategories()
        }
    }
    
//MARK: - Category Selected Method
    
    @IBAction func categoryButtonPressed(_ sender: UIButton) {
        if let categoryName = sender.titleLabel?.text {
            switch categoryName {
                case K.peopleCategory:
                    words = wordArray.people!
                case K.foodCategory:
                    words = wordArray.food!
                case K.worldCategory:
                    words = wordArray.world!
                case K.objectsCategory:
                    words = wordArray.objects!
                case K.varietyCategory:
                    words = wordArray.variety!
                case K.popCultureCategory:
                    words = wordArray.popCulture!
                default:
                    gameManager.appAlert(title: "Error", message: "Error selecting a category. Please try again.", viewController: self)
            }
        }
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.goToGameVC, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.goToGameVC {
            let destinationVC = segue.destination as! GameViewController
            destinationVC.words = words
        }
    }

//MARK: - Go To Add Word VC
    
    @IBAction func addNewWordPressed(_ sender: UIBarButtonItem) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.goToAddWordVC, sender: self)
        }
    }
    
//MARK: - Go To Settings VC
    
    @IBAction func settingsButtonPressed(_ sender: UIBarButtonItem) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.goToSettingsVC, sender: self)
        }
    }
    
//MARK: - Unlock More Categories In-App Purchase Button
    
    @IBAction func unlockMoreCategoriesPressed(_ sender: UIButton) {
        buyAdditionalCategories()
    }

//MARK: - Show Additional Categories Method
    
    func showAdditionalCategories() {
        UserDefaults.standard.set(true, forKey: K.productID)
        DispatchQueue.main.async {
            self.popCultureButton.isHidden = false
            self.varietyButton.isHidden = false
            self.unlockMoreCategoriesButton.isHidden = true
        }
    }
}

//MARK: - SK Payment Transaction Methods

extension CategoryViewController: SKPaymentTransactionObserver {
    
    func buyAdditionalCategories() {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = K.productID
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            gameManager.appAlert(title: "Error", message: "Error with payment request. Please check parental controls in settings and try again.", viewController: self)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                gameManager.appAlert(title: "Successful", message: "The transaction was successful.", viewController: self)
                showAdditionalCategories()
                SKPaymentQueue.default().finishTransaction(transaction)
                
            } else if transaction.transactionState == .failed {
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    gameManager.appAlert(title:"Error", message: "Error with transaction: \(errorDescription). Please try again.", viewController: self)
                }
                SKPaymentQueue.default().finishTransaction(transaction)
                
            } else if transaction.transactionState == .restored {
                showAdditionalCategories()
                self.navigationController?.popToRootViewController(animated: true)
                gameManager.appAlert(title: "Successful", message: "Purchase successfully restored.", viewController: self)
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
}

