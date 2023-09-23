//
//  RestaurantsService.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 29/05/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class RestaurantsService: RestaurantsUseCase {
    
    let networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
      
    func fetchResturantList(pinCode: String, completion: @escaping (Result<[DataEntity], NetworkServiceError>) -> Void) {
//        let parameters: [String:String] = ["pincode" : pinCode]
        let endPoint = "/chef/service/restaurants"
        let additionalHeaders: [String: String] = ["Content-Type": "application/json", "Accept" : "application/json"]
        networkManager.callAPI(.get, endPoint: endPoint,
                               additionalHeaders: additionalHeaders) { (result: Result<RestaurantResponse, NetworkServiceError>) in
            completion(result.map { data in
                return data.asDomain()
            })
        }
    }
    
}
