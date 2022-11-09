//
//  AuthCoordinator.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 18/04/22.
//

import UIKit
import Foundation

class AuthCoordinator: BaseCoordinator {
    
    let rootViewController: UINavigationController
    let sceneProvider: AuthSceneProvider
    let homeSceneProvider: HomeSceneProvider
    
    init(rootViewController: UINavigationController,
         sceneProvider: AuthSceneProvider,
         homeSceneProvider: HomeSceneProvider) {
        self.rootViewController = rootViewController
        self.sceneProvider = sceneProvider
        self.homeSceneProvider = homeSceneProvider
    }
    
    func start() {
        showLoginView()
    }
    
    func showLoginView() {
        let controller = sceneProvider.makeLoginScene()
        controller.navigateToOTPClosure = { [self] number in
            self.showOTPView(phone: number)
        }
        rootViewController.setViewControllers([controller], animated: false)
    }
    
    func showOTPView(phone: OTPDataEntity) {
        let controller = sceneProvider.makeOTPScene(phone: phone)
        controller.navigateBackClosure = { [weak self] in
            self?.rootViewController.popViewController(animated: true)
        }
        controller.navigateToHomeClosure = { [weak self] in
            self?.showHomePage()
        }
        rootViewController.pushViewController(controller, animated: true)
    }
    
    func showHomePage() {
        let coordinator = HomeCoordinator(rootViewController: rootViewController, sceneProvider: homeSceneProvider)
        coordinator.start()
    }
    
}
