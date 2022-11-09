//
//  AppDelegate.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 16/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()
        return true
    }
            
}

