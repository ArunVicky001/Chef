//
//  HomeCoordinator.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 29/05/22.
//

import UIKit
import Foundation

class HomeCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController
    
    let sceneProvider: HomeSceneProvider
    
    init(rootViewController: UINavigationController,
         sceneProvider: HomeSceneProvider) {
        self.rootViewController = rootViewController
        self.sceneProvider = sceneProvider
    }
    
    func start() {
        showHomeView()
    }
    
    func showHomeView() {
        let controller = sceneProvider.makeHomeScene()
        controller.navigateToMenuListClosure = { result in
            self.showMenuListView(restaurantData: result)
        }
        rootViewController.setViewControllers([controller], animated: false)
    }
    
    func showMenuListView(restaurantData: DataEntity) {
        let controller = sceneProvider.makeMenuListScene(with: restaurantData)
        controller.navigateBackClosure = {
            self.rootViewController.popViewController(animated: true)
        }
        controller.checkoutClosure = {
            self.showViewCartPage()
        }
        rootViewController.pushViewController(controller, animated: true)
    }
    
    func showViewCartPage() {
        let controller = sceneProvider.makeViewCartScene()
        controller.navigateBackClosure = {
            self.rootViewController.popViewController(animated: true)
        }
        controller.paymentClosure = {
            self.showOrderTracking()
        }
        rootViewController.pushViewController(controller, animated: true)
    }
    
    func showOrderTracking() {
        let controller = sceneProvider.makeOrderTrackingScene()
        controller.navigateBackClosure = {
            self.rootViewController.popViewController(animated: true)
        }
        rootViewController.pushViewController(controller, animated: true)
    }
    
}
