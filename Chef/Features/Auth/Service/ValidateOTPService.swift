//
//  ValidateOTPService.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 21/05/22.
//

import Foundation

class ValidateOTPService: ValidateOTPUseCase {
   
    let networkManager: TPNetworkManager
    init(networkManager: TPNetworkManager) {
        self.networkManager = networkManager
    }
    
    func validate(mobileNumber: String, deviceID: String, otp: String, completion: @escaping (Result<ValidateOTPDataEntity, NetworkServiceError>) -> Void) {
        let parameters: [String:String] = ["mobileNumber" : mobileNumber, "deviceId" : deviceID, "otp": otp]
        let endPoint = "/chef/service/mobile/validateOtp"
        let additionalHeaders: [String: String] = ["Content-Type": "application/json", "Accept" : "application/json"]
        networkManager.callAPI(.post, endPoint: endPoint,
                               parameters: parameters,
                               additionalHeaders: additionalHeaders) { (result: Result<ValidateOTPDataResponse, NetworkServiceError>) in
            completion(result.map { data in
                return data.asDomain()
            })
        }
    }
    
}
