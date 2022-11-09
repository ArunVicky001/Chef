//
//  LoginViewController.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 16/04/22.
//

import UIKit
import CoreLocation
import CoreLocationUI

class LoginViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var userNamebgView: UIView!
    @IBOutlet weak var phoneNumberbgView: UIView!
    @IBOutlet weak var borderLine: UILabel!
    
    private let keyboardObserver = UnderKeyboardObserver()
    var navigateToOTPClosure: ((OTPDataEntity) -> Void)!
    
    var viewModel: LoginViewModel!
    convenience init(viewModel: LoginViewModel) {
        self.init(nibName: "LoginViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInterface()
        self.setupBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        phoneNumberTextField.becomeFirstResponder()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .black
    }
           
    func setupInterface() {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
//        if CLLocationManager.locationServicesEnabled() {
//            switch CLLocationManager.authorizationStatus() {
//            case .notDetermined, .restricted, .denied:
//                showPermissionAlert()
//            case .authorizedAlways, .authorizedWhenInUse:
//                locationManager.startUpdatingLocation()
//            @unknown default: break
//
//            }
//        } else {
//            locationManager.startUpdatingLocation()
//        }
        
        keyboardObserver.start()
        keyboardObserver.willAnimateKeyboard = { [weak buttonBottomConstraint] height in
            buttonBottomConstraint?.constant = height + 10
        }
        keyboardObserver.animateKeyboard = { [weak self] height in
            self?.view.layoutIfNeeded()
        }
        
        self.userNamebgView.layer.cornerRadius = 8
        self.userNamebgView.backgroundColor = .grey100
        self.phoneNumberbgView.layer.cornerRadius = 8
        self.phoneNumberbgView.backgroundColor = .grey100
        self.borderLine.backgroundColor = .grey100
        
    }
    
    func setupBindings() {
        viewModel.loginResponse += PropertyObserver(uniqueTarget: self, callback: { [weak self] response in
            guard let self = self, let data = response else { return }
            print("mobile number :\(data.mobileNumber)")
            self.navigateToOTPClosure(data)
        })
    }
        
    //MARK: - IBActions
    @IBAction func getOTP(_ sender: Any) {
        self.viewModel.loginUser(phoneNumber: phoneNumberTextField.text ?? "")
    }
    
//    func showPermissionAlert(){
//        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
//
//        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
//            //Redirect to Settings app
//            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
//        })
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
//        alertController.addAction(cancelAction)
//
//        alertController.addAction(okAction)
//
//        self.present(alertController, animated: true, completion: nil)
//    }
    
}
