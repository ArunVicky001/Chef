//
//  OrderTrackingService.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 14/06/22.
//

import Foundation

class OrderTrackingService: OrderTrackingUseCase {
    let networkManager: TPNetworkManager
    init(networkManager: TPNetworkManager) {
        self.networkManager = networkManager
    }
}
