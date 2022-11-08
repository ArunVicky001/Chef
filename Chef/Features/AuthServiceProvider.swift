//
//  AuthServiceProvider.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 05/05/22.
//

import Foundation

class AuthServiceProvider: AuthUseCaseProvider {
    
    let networkManager: TPNetworkManager
    init(networkManager: TPNetworkManager) {
        self.networkManager = networkManager
    }
    
    func loginUseCase() -> LoginUseCase {
        return LoginService(networkManager: networkManager)
    }
    func validateOTPUseCase() -> ValidateOTPUseCase {
        return ValidateOTPService(networkManager: networkManager)
    }
    
}
