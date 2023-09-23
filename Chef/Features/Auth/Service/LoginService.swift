//
//  LoginService.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 03/05/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginService: LoginUseCase {
    
    let networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func loginUser(phone: String, completion: @escaping (Result<OTPDataEntity, NetworkServiceError>) -> Void) {
        let parameters: [String:String] = ["mobileNumber" : phone, "deviceId" : "test123", "smsText": "Welcome"]
        let endPoint = "/chef/service/mobile/sendOtp"
        let additionalHeaders: [String: String] = ["Content-Type": "application/json", "Accept" : "application/json"]
        networkManager.callAPI(.post, endPoint: endPoint,
                               parameters: parameters,
                               additionalHeaders: additionalHeaders) { (result: Result<OTPDataResponse, NetworkServiceError>) in
            completion(result.map { data in
                return data.asDomain()
            })
        }
    }
}
