//
//  LoginViewController.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 16/04/22.
//

import Foundation
import UIKit

class AuthSceneProvider {
    
    let useCaseProvider: AuthUseCaseProvider
    
    init(useCaseProvider: AuthUseCaseProvider) {
        self.useCaseProvider = useCaseProvider
    }
    
    func makeLoginScene() -> LoginViewController {
        let viewModel = LoginViewModel()
        let controller = LoginViewController(viewModel: viewModel)
        return controller
    }
        
}
