//
//  AppServiceProvider.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 05/05/22.
//

import Foundation

class AppServiceProvider {
    
    func makeAuthServiceProvider() -> AuthUseCaseProvider {
        let netWorkManager = NetworkManager(baseURL: AppConfiguration.baseURL)
        return AuthServiceProvider(networkManager: netWorkManager)
    }
    
    func makeDashboardServiceProvider() -> HomeUseCaseProvider {
        let netWorkManager = NetworkManager(baseURL: AppConfiguration.baseURL)
        return DashboardServiceProvider(networkManager: netWorkManager)
    }
    
}
