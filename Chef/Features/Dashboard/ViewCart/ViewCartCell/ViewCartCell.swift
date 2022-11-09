//
//  ViewCartCell.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 10/06/22.
//

import UIKit

class ViewCartCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var quandityLabel: UILabel!

    var plusBtnTapAction: (() -> Void)!
    var minusBtnTapAction: (() -> Void)!
    var quandityClosure: ((Int, Int) -> Void)!
    

    static let cellHeight: CGFloat = 150
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 15
        
        plusBtnTapAction = {
            guard let quandity = self.quandityLabel.text else { return }
            self.quandityLabel.text = "\(Int(quandity)! + 1)"
            self.quandityLabel.textColor = .black
        }
        
        minusBtnTapAction = {
            let quantity = Int(self.quandityLabel.text!)
            if quantity! > 0 {
                self.quandityLabel.text = "\(quantity! - 1)"
                if self.quandityLabel.text == "0" {
                    self.quandityLabel.textColor = .lightGray
                }
            }
        }
       
    }

    func setup(with model: MenuDataEntity) {
        foodName.text = model.title
        foodPrice.text = "$2"
    }
    
    @IBAction func btnActionPlus(_ sender: UIButton) {
        plusBtnTapAction()
    }
    
    @IBAction func btnActionMinus(_ sender: UIButton) {
        minusBtnTapAction()
    }
    
}
