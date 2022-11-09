//
//  ChefButton.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 19/04/22.
//

import UIKit

class RedButton: OrangeButton {
    override var selectedColor: UIColor { return .chefOrange }
}

class OrangeButton: LoadingButton {
    
    var selectedColor: UIColor { return .chefOrange }
    
    override var isEnabled: Bool {
        didSet {
            let color = isEnabled ? selectedColor : UIColor.charcoalGrey.withAlphaComponent(0.4)
            self.backgroundColor = color
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = selectedColor
        self.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
        self.setTitleColor(.white, for: .normal)
        self.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8
    }
}


class BorderedButton: LoadingButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
        self.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height/2
    }

}
