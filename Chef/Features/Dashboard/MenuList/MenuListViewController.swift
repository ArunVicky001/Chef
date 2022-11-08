//
//  ManuListViewController.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 04/06/22.
//

import UIKit

class MenuListViewController: UIViewController {

    convenience init(viewModel: MenuListViewModel) {
        self.init(nibName: "ManuListViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
