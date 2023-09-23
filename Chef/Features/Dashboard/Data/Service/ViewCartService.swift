//
//  ViewCartService.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 10/06/22.
//

import Foundation

class ViewCartService: ViewCartUseCase {
    
    let networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
}
