//
//  OrderTrackingService.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 14/06/22.
//

import Foundation

class OrderTrackingService: OrderTrackingUseCase {
    let networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}
