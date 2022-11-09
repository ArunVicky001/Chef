//
//  OTPViewModel.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 16/04/22.
//

import Foundation

class OTPViewModel {
    
    let phone: OTPDataEntity
    let validateOTPUseCase: ValidateOTPUseCase
    let loginUseCase: LoginUseCase
    var validateOTPResponse = ObservableProperty<ValidateOTPDataEntity?>(value: nil)
    var loginResponse = ObservableProperty<OTPDataEntity?>(value: nil)
    var error = ObservableProperty<String?>(value: nil)
    var enteredOTP: String?
    
    init(phone: OTPDataEntity, validateOTPUseCase: ValidateOTPUseCase, loginUseCase: LoginUseCase) {
        self.phone = phone
        self.validateOTPUseCase = validateOTPUseCase
        self.loginUseCase = loginUseCase
    }
    
    //MARK: - Public Methods
    func viewLoaded() {
    }
    
    func validateOTP(phoneNumber: String, deviceID: String, otp: String) {
        validateOTPUseCase.validate(mobileNumber: phoneNumber, deviceID: deviceID, otp: otp) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.validateOTPResponse.value = data
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
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

