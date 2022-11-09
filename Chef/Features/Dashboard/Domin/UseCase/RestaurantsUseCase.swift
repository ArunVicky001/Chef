//
//  RestaurantsUseCase.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 29/05/22.
//

import Foundation

protocol RestaurantsUseCase {
    func fetchResturantList(pinCode: String, completion: @escaping (Result<[DataEntity], NetworkServiceError>) -> Void)
}
