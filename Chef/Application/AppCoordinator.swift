//
//  AppCoordinator.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 18/04/22.
//

import UIKit

class AppCoordinator {
    let window: UIWindow
    let serviceProvider = AppServiceProvider()
    
    lazy var rootViewController: UINavigationController = {
       let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
        
    init(window: UIWindow) {
        self.window = window
        self.window.makeKeyAndVisible()
        self.window.rootViewController = self.rootViewController
    }
    
    func start() -> (Void) {
        if AppUserDefaults.shared.loginSesion == true {
            HomeViewController()
        } else {
            loginViewController()
        }
    }
    
    func loginViewController() {
        let sceneProvider = AuthSceneProvider(useCaseProvider: serviceProvider.makeAuthServiceProvider())
        let homeSceneProvider = HomeSceneProvider(useCaseProvider: serviceProvider.makeDashboardServiceProvider())
        let authCoordinator = AuthCoordinator(rootViewController: rootViewController, sceneProvider: sceneProvider, homeSceneProvider: homeSceneProvider)
        authCoordinator.start()
    }
            
    func HomeViewController() {
        let sceneProvider = HomeSceneProvider(useCaseProvider: serviceProvider.makeDashboardServiceProvider())
        let homeCoordinator = HomeCoordinator(rootViewController: rootViewController, sceneProvider: sceneProvider)
        homeCoordinator.start()
    }
}

