//
//  MenuService.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 29/05/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class MenuService: MenuUseCase {
    
    let networkManager: TPNetworkManager
    init(networkManager: TPNetworkManager) {
        self.networkManager = networkManager
    }
       
    func fetchMenuList(restaurentID: String, completion: @escaping (Result<[MenuDataEntity], NetworkServiceError>) -> Void) {
//        let parameters: [String:String] = ["restaurentID" : restaurentID]
        let endPoint = "/chef/service/menu"
        let additionalHeaders: [String: String] = ["Content-Type": "application/json", "Accept" : "application/json"]
        networkManager.callAPI(.get, endPoint: endPoint,
                               additionalHeaders: additionalHeaders) { (result: Result<MenuResponse, NetworkServiceError>) in
            completion(result.map { data in
                return data.asDomain()
            })
        }
    }
    
}
