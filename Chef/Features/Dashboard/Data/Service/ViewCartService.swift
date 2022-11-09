//
//  ViewCartService.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 10/06/22.
//

import Foundation

class ViewCartService: ViewCartUseCase {
    
    let networkManager: TPNetworkManager
    init(networkManager: TPNetworkManager) {
        self.networkManager = networkManager
    }
    
}
