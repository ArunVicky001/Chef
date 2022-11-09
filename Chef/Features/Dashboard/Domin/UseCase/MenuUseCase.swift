//
//  MenuUseCase.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 29/05/22.
//

import Foundation

protocol MenuUseCase {
    func fetchMenuList(restaurentID: String, completion: @escaping (Result<[MenuDataEntity], NetworkServiceError>) -> Void) 
}
