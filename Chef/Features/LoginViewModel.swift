//
//  LoginViewModel.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 16/04/22.
//

import Foundation

class LoginViewModel {
    
    let loginUseCase: LoginUseCase
    var loginResponse = ObservableProperty<OTPDataEntity?>(value: nil)
    var error = ObservableProperty<String?>(value: nil)
    
    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }
    
    //MARK: - Public Methods
    func viewLoaded() {
        
    }
    
    func loginUser(phoneNumber: String) {
        loginUseCase.loginUser(phone: phoneNumber) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.loginResponse.value = data
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
    
}
