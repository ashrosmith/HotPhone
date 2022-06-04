//
//  StartViewController.swift
//  HotPhone
//
//  Created by Ashley Smith on 5/6/22.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var hotPhoneLabel: UILabel!
    let gameManager = GameManager()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hotPhoneLabel.center.x = view.center.x
        hotPhoneLabel.center.x -= view.bounds.width
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
    }
   
    private func animate() {
        UIView.animate(withDuration: 1, delay: 0, options: [.curveLinear], animations: {
            self.hotPhoneLabel.center.x += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 1.5, delay: 1, animations: {
            self.hotPhoneLabel.alpha = 0
            self.imageView.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    if UIApplication.isFirstTimeOpening() == true {
                        self.performSegue(withIdentifier: K.showRules, sender: self)
                    }
                    else {
                        self.performSegue(withIdentifier: K.startGame, sender: self)
                    }
                })
            }
        })
    }

}
