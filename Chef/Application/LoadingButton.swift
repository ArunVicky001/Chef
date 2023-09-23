//
//  LoadingButton.swift
//  OnboardingLibraryiOS


import UIKit

class LoadingButton: UIButton {
    
    var activityIndicatorStyle: UIActivityIndicatorView.Style {
        if #available(iOS 13.0, *) {
            return .medium
        } else {
            return .white
        }
    }
    
    private var title: String?
    private var image: UIImage?
    
    private let activityIndicator = UIActivityIndicatorView()
    var isLoading: Bool = false {
        didSet {
            isUserInteractionEnabled = !isLoading
            activityIndicator.color = self.titleColor(for: .normal)
            if isLoading {
                activityIndicator.startAnimating()
                removeTitleAndImage()
            } else {
                activityIndicator.stopAnimating()
                resetTitleAndImage()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.title = self.titleLabel?.text
        self.image = self.currentImage
        
        activityIndicator.style = activityIndicatorStyle
        self.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }

    private func removeTitleAndImage() {
        super.setImage(nil, for: .normal)
        super.setTitle(nil, for: .normal)
    }
    
    private func resetTitleAndImage() {
        super.setImage(self.image, for: .normal)
        super.setTitle(self.title, for: .normal)
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        self.title = title
        super.setTitle(self.title, for: state)
    }
    
}
