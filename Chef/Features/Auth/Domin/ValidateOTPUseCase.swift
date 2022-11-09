//
//  ValidateOTPUseCase.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 21/05/22.
//

import Foundation

protocol ValidateOTPUseCase {
    func validate(mobileNumber: String, deviceID: String, otp: String, completion: @escaping (Result<ValidateOTPDataEntity, NetworkServiceError>) -> Void)
}
