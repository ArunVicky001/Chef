//
//  ViewCartViewModel.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 10/06/22.
//

import Foundation

class ViewCartViewModel {
    
    let menuUseCase: MenuUseCase
    var cartListResponse = [MenuDataEntity]()
    var reloadSubjectsData = ObservableProperty(value: false)
    var error = ObservableProperty<String?>(value: nil)
    
    init(menuUseCase: MenuUseCase) {
        self.menuUseCase = menuUseCase
    }
    
    func viewLoad() {
        fetchCartList(cartID: 0)
    }
    
    func fetchCartList(cartID: Int) {
        menuUseCase.fetchMenuList(restaurentID: "") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.cartListResponse = data
                self.reloadSubjectsData.value = true
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
}
