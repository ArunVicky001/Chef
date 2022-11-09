//
//  OrderViewController.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 14/06/22.
//

import UIKit

class OrderViewController: UIViewController {
    
    var navigateBackClosure: VoidClosure!
    var viewModel: OrderTrackingViewModel!
    
    convenience init(viewModel: OrderTrackingViewModel) {
        self.init(nibName: "OrderViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()       
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigateBackClosure()
    }

}
