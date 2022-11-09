//
//  RestaurantCell.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 31/05/22.
//

import UIKit

class RestaurantCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantType: UILabel!
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    
    static let cellHeight: CGFloat = 160
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 15
    }

    func setup(with model: DataEntity) {
        restaurantName.text = model.name
        restaurantType.text = model.type
        deliveryTimeLabel.text = "4.2 (50+) - 30 Mins"
    }
    
}
