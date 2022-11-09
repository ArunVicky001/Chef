//
//  OTPViewController.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 16/04/22.
//

import UIKit

class OTPViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var codeSentLabel: UILabel!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var resendOTPButton: UIButton!
    @IBOutlet weak var otpTextFieldView: OTPFieldView!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var verifyOTPButton: OrangeButton!
    
    var viewModel: OTPViewModel!
    var navigateBackClosure: VoidClosure!
    var navigateToHomeClosure: VoidClosure!
    private let keyboardObserver = UnderKeyboardObserver()
    
    convenience init(viewModel: OTPViewModel) {
        self.init(nibName: "OTPViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupBindings()
    }
    
    private
    func setupInterface() {
        self.navigationController?.isNavigationBarHidden = true
        codeSentLabel.text = "sent to \(viewModel.phone.mobileNumber) OTP : \(viewModel.phone.otp)"
        errorLabel.text = ""
        verifyOTPButton.isEnabled = false
        setupOtpView()
        keyboardObserver.start()
        keyboardObserver.willAnimateKeyboard = { [weak buttonBottomConstraint] height in
            buttonBottomConstraint?.constant = height + 10
        }
        keyboardObserver.animateKeyboard = { [weak self] height in
            self?.view.layoutIfNeeded()
        }
    }
    
    func setupOtpView(){
        self.otpTextFieldView.fieldsCount = 6
        self.otpTextFieldView.fieldBorderWidth = 2
        self.otpTextFieldView.defaultBorderColor = UIColor.hexF0F0F1
        self.otpTextFieldView.filledBorderColor = UIColor.chefOrange
        self.otpTextFieldView.cursorColor = UIColor.black
        self.otpTextFieldView.displayType = .underlinedBottom
        self.otpTextFieldView.fieldSize = 50
        self.otpTextFieldView.separatorSpace = 8
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
    }
    
    private
    func setupBindings() {
        viewModel.loginResponse += PropertyObserver(uniqueTarget: self, callback: { [weak self] response in
            guard let self = self, let data = response else { return }
            self.codeSentLabel.text = "sent to \(data.mobileNumber) OTP : \(data.otp)"
        })
        
        viewModel.validateOTPResponse += PropertyObserver(uniqueTarget: self, callback: { [weak self] response in
            guard let self = self, let data = response else { return }
            print("status mesage :\(data)")
            AppUserDefaults.shared.loginSesion = true
            self.navigateToHomeClosure()
            
        })
        
        viewModel.error += PropertyObserver(uniqueTarget: self, callback: { [weak self] response in
            guard let self = self, let data = response else { return }
            if data.count > 0 {
                self.errorLabel.isHidden = false
            }
        })
    }
    
    //MARK:- IBAction Methods
    @IBAction func verifyOTP(_ sender: Any) {
        self.errorLabel.isHidden = true
        viewModel.validateOTP(phoneNumber: viewModel.phone.mobileNumber, deviceID: viewModel.phone.deviceId, otp: viewModel.enteredOTP ?? "")
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigateBackClosure()
    }
    
    @IBAction func resendOTP(_ sender: Any) {
        self.errorLabel.isHidden = true
        self.viewModel.loginUser(phoneNumber: viewModel.phone.mobileNumber)
    }
}

// MARK: OtpTextFieldDelegate Methods
extension OTPViewController: OTPFieldViewDelegate {
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        self.viewModel.enteredOTP = otp
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        verifyOTPButton.isEnabled = hasEnteredAll
        print("Has entered all OTP? \(hasEnteredAll)")
        return hasEnteredAll
    }
}
