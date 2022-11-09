//
//  HomeSceneProvider.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 29/05/22.
//

import Foundation

class HomeSceneProvider {
    let useCaseProvider: HomeUseCaseProvider

    init(useCaseProvider: HomeUseCaseProvider) {
        self.useCaseProvider = useCaseProvider
    }
    
    func makeHomeScene() -> HomeViewController {
        let viewModel = HomeViewModel(menuUseCase: useCaseProvider.menuUseCase(), restaurantsUseCase: useCaseProvider.restaurantsUseCaseUseCase())
        let controller = HomeViewController(viewModel: viewModel)
        return controller
    }
    
    func makeMenuListScene(with dataEntity: DataEntity) -> MenuListViewController {
        let headerModel = ModuleHeaderViewModel(title: dataEntity.name, description: dataEntity.type)
        let viewModel = MenuListViewModel(headerViewModel: headerModel, menuUseCase: useCaseProvider.menuUseCase(), restaurantData: dataEntity)
        let controller = MenuListViewController(viewModel: viewModel)
        return controller
    }
    
    func makeViewCartScene() -> ViewCartViewController {
        let viewModel = ViewCartViewModel(menuUseCase: useCaseProvider.menuUseCase())
        let controller = ViewCartViewController(viewModel: viewModel)
        return controller
    }
    
    func makeOrderTrackingScene() -> OrderViewController {
        let viewModel = OrderTrackingViewModel()
        let controller = OrderViewController(viewModel: viewModel)
        return controller
    }
}
