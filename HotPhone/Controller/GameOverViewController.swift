//
//  GameOverViewController.swift
//  HotPhone
//
//  Created by Ashley Smith on 1/14/22.
//

import UIKit
import AVFoundation

class GameOverViewController: UIViewController {
    
    let gameManager = GameManager()
    var player = AVAudioPlayer()
    
    @IBOutlet weak var winningTeam: UILabel!
    @IBOutlet weak var finalScore: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        imageView.setGIFImage(name: K.fireworksGIF)
        gameManager.playSound(soundName: K.gameOverSound)
        if gameManager.team1Score > gameManager.team2Score {
            winningTeam.text = K.team1Won
            finalScore.text = "\(gameManager.team1Score) - \(gameManager.team2Score)"
        } else if gameManager.team2Score > gameManager.team1Score {
            winningTeam.text = K.team2Won
            finalScore.text = "\(gameManager.team2Score) - \(gameManager.team1Score)"
        } else if gameManager.team2Score == gameManager.team1Score{
            winningTeam.text = K.tie
            finalScore.text = "\(gameManager.team1Score) - \(gameManager.team2Score)"
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.stop()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imageView.stopAnimating()
        gameManager.reset()
    }
       
//MARK: - Play Again Method
    
    @IBAction func playAgainPressed(_ sender: UIButton) {
        gameManager.reset()
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.playAgain, sender: self)
        }
    }
}
    
//MARK: - GIF Extension Methods

extension UIImageView {
    func setGIFImage(name: String, repeatCount: Int = 0 ) {
        DispatchQueue.global().async {
            if let gif = UIImage.makeGIFFromCollection(name: name, repeatCount: repeatCount) {
                DispatchQueue.main.async {
                    self.setImage(withGIF: gif)
                    self.startAnimating()
                }
            }
        }
    }
    private func setImage(withGIF gif: GIF) {
        animationImages = gif.images
        animationDuration = gif.durationInSec
        animationRepeatCount = gif.repeatCount
    }
}

extension UIImage {
    
    class func makeGIFFromCollection(name: String, repeatCount: Int = 0) -> GIF? {
        guard let path = Bundle.main.path(forResource: name, ofType: "gif") else {
            print("Cannot find a path from the file \"\(name)\"")
            return nil
        }

        let url = URL(fileURLWithPath: path)
        let data = try? Data(contentsOf: url)
        guard let d = data else {
            print("Cannot turn image named \"\(name)\" into data")
            return nil
        }

        return makeGIFFromData(data: d, repeatCount: repeatCount)
    }
    
    class func makeGIFFromData(data: Data, repeatCount: Int = 0) -> GIF? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("Source for the image does not exist")
            return nil
        }

        let count = CGImageSourceGetCount(source)
        var images = [UIImage]()
        var duration = 0.0

        for i in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                let image = UIImage(cgImage: cgImage)
                images.append(image)

                let delaySeconds = UIImage.delayForImageAtIndex(Int(i), source: source)
                duration += delaySeconds
            }
        }

        return GIF(images: images, durationInSec: duration, repeatCount: repeatCount)
    }
    
        class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
            var delay = 0.0
            let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
            let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
            if CFDictionaryGetValueIfPresent(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque(), gifPropertiesPointer) == false {
                return delay
            }

            let gifProperties:CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
            var delayObject: AnyObject = unsafeBitCast(
                CFDictionaryGetValue(gifProperties,
                                     Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
                to: AnyObject.self)
            if delayObject.doubleValue == 0 {
                delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                                 Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
            }

            delay = delayObject as? Double ?? 0

            return delay
        }
    }

    class GIF: NSObject {
        let images: [UIImage]
        let durationInSec: TimeInterval
        let repeatCount: Int

        init(images: [UIImage], durationInSec: TimeInterval, repeatCount: Int = 0) {
            self.images = images
            self.durationInSec = durationInSec
            self.repeatCount = repeatCount
        }
    }

