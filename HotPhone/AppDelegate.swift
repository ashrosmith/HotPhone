//
//  AppDelegate.swift
//  HotPhone
//
//  Created by Ashley Smith on 1/12/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let defaults = UserDefaults.standard
        let prefs = Bundle.main.path(forResource: "Defaults", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: prefs!)
        defaults.set(dict, forKey: "defaults")
        defaults.register(defaults: dict as! [String : AnyObject])
        defaults.synchronize()
       
        return true
    }
    


    // MARK: - UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}

extension UIApplication {
    class func isFirstTimeOpening() -> Bool {
        let defaults = UserDefaults.standard

        if(defaults.integer(forKey: "hasRun") == 0) {
            defaults.set(1, forKey: "hasRun")
            return true
        }
        return false
      }
}








