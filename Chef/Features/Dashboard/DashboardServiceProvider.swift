//
//  DashboardServiceProvider.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 29/05/22.
//

import Foundation

class DashboardServiceProvider: HomeUseCaseProvider {
   
    let networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func menuUseCase() -> MenuUseCase {
        return MenuService(networkManager: networkManager)
    }

    func restaurantsUseCaseUseCase() -> RestaurantsUseCase {            
        return RestaurantsService(networkManager: networkManager)
    }
    
    func orderTrackingUseCase() -> OrderTrackingUseCase {
        return OrderTrackingService(networkManager: networkManager)
    }
    
}
