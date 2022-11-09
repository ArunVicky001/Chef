//
//  ManuListViewModel.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 04/06/22.
//

import Foundation

class MenuListViewModel {
    let headerViewModel: ModuleHeaderViewModel
    let menuUseCase: MenuUseCase
    let restaurantData: DataEntity
    var menuListResponse = [MenuDataEntity]()
    var reloadSubjectsData = ObservableProperty(value: false)
    var error = ObservableProperty<String?>(value: nil)
    var totalCartCount = [Int]()
    
    init(headerViewModel: ModuleHeaderViewModel, menuUseCase: MenuUseCase, restaurantData: DataEntity) {
        self.headerViewModel = headerViewModel
        self.menuUseCase = menuUseCase
        self.restaurantData = restaurantData
    }
    
    func viewLoad() {
        fetchMenuList(restaurentID: restaurantData.id)
    }
    
    func fetchMenuList(restaurentID: Int) {
        menuUseCase.fetchMenuList(restaurentID: "") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.menuListResponse = data
                self.totalCartCount = [Int](repeating: 0, count: data.count)
                self.reloadSubjectsData.value = true
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
    
}
    
