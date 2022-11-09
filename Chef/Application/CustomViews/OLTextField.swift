//
//  OLTextField.swift
//  Toppr
//
//  Created by Vedant Mahant on 25/01/19.
//  Copyright © 2019 Toppr. All rights reserved.
//

import UIKit

class OLTextField: SelfDesigningView {
    
    //MARK: - IBOutlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var underlineView: UIView!
    
    @IBOutlet var titleLabelVerticalCenterConstraint: NSLayoutConstraint!
    //MARK: - Computed Properties
    @IBInspectable
    public var placeHolder: String? {
        get { return textField.placeholder }
        set {
            textField.placeholder = newValue
            title = newValue
        }
    }
    
    @IBInspectable
    public var autoCorrectType: UITextAutocorrectionType {
        get { return textField.autocorrectionType }
        set {
            textField.autocorrectionType = newValue
        }
    }
    
    @IBInspectable
    public var text: String {
        get { return textField.text ?? "" }
        set {
            textField.text = newValue
            self.editingChanged()
        }
    }
    
    @IBInspectable
    public var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    @IBInspectable
    public var errorMessage: String {
        get { return errorLabel.text ?? "" }
        set {
            errorLabel.text = newValue
            if newValue.isEmpty {
                underlineColor = titleColor
            } else {
                underlineColor = errorColor
            }
        }
    }
    
    @IBInspectable
    public var textColor: UIColor? {
        get { return textField.textColor }
        set { textField.textColor = newValue }
    }
    
    @IBInspectable
    public var titleColor: UIColor? {
        get { return titleLabel.textColor }
        set {
            titleLabel.textColor = newValue
            underlineColor = newValue
        }
    }
    
    @IBInspectable
    public var errorColor: UIColor {
        get { return errorLabel.textColor ?? .red }
        set { errorLabel.textColor = newValue }
    }
    
    @IBInspectable
    public var underlineColor: UIColor? {
        get { return underlineView.backgroundColor }
        set { underlineView.backgroundColor = newValue }
    }
    
    var leftView: UIView? {
        get { return textField.leftView }
        set {
            textField.leftView = newValue
            textField.leftViewMode = .always
        }
    }
    
    var rightView: UIView? {
        get { return textField.rightView }
        set {
            textField.rightView = newValue
            textField.rightViewMode = .always
        }
    }
    
    public var noOfLines: Int {
        get { return errorLabel.numberOfLines }
        set { errorLabel.numberOfLines = newValue }
    }
    
    public var titleFont: UIFont? {
        get { return titleLabel.font }
        set { titleLabel.font = newValue }
    }
    
    public var font: UIFont? {
        get { return textField.font }
        set { textField.font = newValue }
    }
    
    @IBInspectable
    var isSecure: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecure
        }
    }
    
    @IBInspectable
    var isNumberEntry: Bool = false {
        didSet {
            if isNumberEntry {
                textField.keyboardType = .asciiCapableNumberPad
            } else {
                textField.keyboardType = .default
            }
        }
    }
    
    @IBInspectable
    var shouldCapitalizeWords: Bool = false {
        didSet {
            textField.autocapitalizationType = shouldCapitalizeWords ? .words : .none
        }
    }
    
    public weak var delegate: UITextFieldDelegate? {
        get { return textField.delegate }
        set { textField.delegate = newValue }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setupInterface()
    }
    
    private
    func setupInterface() {
//        textField.font = Fonts.Karla.regular.with(size: 16)
//        errorLabel.font = Fonts.Karla.bold.with(size: 12)
//        titleLabel.font = Fonts.Karla.bold.with(size: 12)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        errorLabel.numberOfLines = 1
        
        titleColor = UIColor.chefGray.withAlphaComponent(0.4)
        underlineColor = UIColor.chefGray.withAlphaComponent(0.4)
        textColor = UIColor.chefGray
        errorColor = UIColor.errorColor
//        font = Fonts.Karla.bold.with(size: 16)
        
        textField.addTarget(self, action: #selector(self.editingChanged), for: .editingChanged)
    }
    
    
    @objc private
    func editingChanged() {
        self.errorMessage = ""
        
        if text.count > 0 {
            guard self.titleLabelVerticalCenterConstraint.isActive else { return }
            self.layer.removeAllAnimations()
            self.titleLabelVerticalCenterConstraint.isActive = false
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let this = self else { return }
                this.layoutIfNeeded()
                this.titleLabel.alpha = 1
                this.titleLabel.textColor = UIColor.chefOrange
                this.underlineView.backgroundColor = UIColor.chefOrange
            })
        } else {
            guard !self.titleLabelVerticalCenterConstraint.isActive else { return }
            self.layer.removeAllAnimations()
            self.titleLabelVerticalCenterConstraint.isActive = true
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let this = self else { return }
                this.layoutIfNeeded()
                this.titleLabel.alpha = 0
                this.titleLabel.textColor = UIColor.charcoalGrey
                this.underlineView.backgroundColor = UIColor.charcoalGrey
            })
        }
    }
}
