//
//  ManuListViewModel.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 04/06/22.
//

import Foundation

class ManuListViewModel {
    
    let menuUseCase: MenuUseCase
    let resturantData: DataEntity
    
    init(menuUseCase: MenuUseCase, resturantData: DataEntity) {
        self.menuUseCase = menuUseCase
        self.resturantData = resturantData
    }
    
    func viewLoad() {
        
    }
    
}
    
