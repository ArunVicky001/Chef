//
//  HomeUseCaseProvider.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 29/05/22.
//

import Foundation

protocol HomeUseCaseProvider {
    func menuUseCase() -> MenuUseCase
    func restaurantsUseCaseUseCase() -> RestaurantsUseCase
    func orderTrackingUseCase() -> OrderTrackingUseCase
}
