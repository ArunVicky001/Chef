//
//  LoginUseCase.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 19/04/22.
//

import Foundation

protocol LoginUseCase {
    func loginUser(phone: String, completion: @escaping (Result<OTPDataEntity, NetworkServiceError>) -> Void)
}
