//
//  ModuleHeaderView.swift
//  SchoolOS


import UIKit

class ModuleHeaderView: SelfDesigningView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
        
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
        titleLabel.font = UIFont(name: "Poppins-Bold", size: 24)
        titleLabel.textColor = UIColor.black
        descriptionLabel.font = UIFont(name: "Poppins-Regular", size: 14)
        descriptionLabel.textColor = UIColor.black.withAlphaComponent(0.5)
    }
  
    func setup(with model: ModuleHeaderViewModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}
