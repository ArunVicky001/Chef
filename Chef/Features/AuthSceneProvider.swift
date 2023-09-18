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
        let viewModel = LoginViewModel(loginUseCase: useCaseProvider.loginUseCase())
        let controller = LoginViewController(viewModel: viewModel)
        return controller
    }
    
    func makeOTPScene(phone: OTPDataEntity) -> OTPViewController {
        let viewModel = OTPViewModel(phone: phone, validateOTPUseCase: useCaseProvider.validateOTPUseCase(), loginUseCase: useCaseProvider.loginUseCase())
        let controller = OTPViewController(viewModel: viewModel)
        return controller
    }
        
}
