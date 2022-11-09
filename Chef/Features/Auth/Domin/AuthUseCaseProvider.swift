//
//  LoginViewController.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 16/04/22.
//

import Foundation

protocol AuthUseCaseProvider {
    func loginUseCase() -> LoginUseCase
    func validateOTPUseCase() -> ValidateOTPUseCase
}

