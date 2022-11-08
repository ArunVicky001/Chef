//
//  ModuleHeaderView.swift
//  SchoolOS
//
//  Created by Bhagyashree Myanamwar on 30/07/20.
//  Copyright © 2020 Toppr. All rights reserved.
//

import UIKit
import TopprUtilitiesiOS

class ModuleHeaderView: SelfDesigningView {

    @IBOutlet weak var titleLabel: TopprLabel!
    @IBOutlet weak var descriptionLabel: TopprLabel!
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInterface()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInterface()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupInterface()
    }
    
 
    private
    func setupInterface() {
        titleLabel.font = Fonts.Karla.bold.with(size: 24 <> 32)
        titleLabel.textColor = .black
        descriptionLabel.font = Fonts.Karla.regular.with(size: 14 <> 18)
        descriptionLabel.textColor = UIColor.black.withAlphaComponent(0.5)
    }
  
    func setup(with model: ModuleHeaderViewModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}
