
//
//  BaseCoordinator.swift
//  SuperTeacher
//
//  Created by Hamza Ansari on 27/07/20.
//  Copyright © 2020 Toppr. All rights reserved.
//

import UIKit

protocol BaseCoordinator {
//    func start()
    func handleDeeplink(request: DeeplinkRequest)
    var rootViewController: UINavigationController { get }
}

extension BaseCoordinator {
    func handleDeeplink(request: DeeplinkRequest){}

    func setRootController(controller: UIViewController, animated: Bool = true) {
        rootViewController.setViewControllers([controller], animated: animated)
    }

    func present(controller: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        rootViewController.present(controller, animated: animated, completion: completion)
    }
    
    func push(controller: UIViewController, animated: Bool = true) {
        rootViewController.pushViewController(controller, animated: animated)
    }
    
    func dismissPresented(animated: Bool = false, completion: (() -> Void)? = nil) {
        if let controller = rootViewController.presentedViewController {
            controller.dismiss(animated: animated, completion: completion)
        } else {
            completion?()
        }
    }
    
    func dismissAndPopToRootView(animated: Bool = false, completion: (() -> Void)? = nil) {
        rootViewController.popToRootViewController(animated: animated)
        dismissPresented(animated: animated, completion: completion)
    }
    
}

