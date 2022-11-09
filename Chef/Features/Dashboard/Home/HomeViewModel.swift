//
//  HomeViewModel.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 29/05/22.
//

import Foundation
import MapKit

protocol HomePageViewModelProtocol {
    var delegate: HomePageViewModelDelegate? { get set }
    func getUserLocation()
}

protocol HomePageViewModelDelegate: AnyObject {    
    func showLocationString(areaName: String, locationString: String)
}

class HomeViewModel: NSObject {
    
    let menuUseCase: MenuUseCase
    let restaurantsUseCase: RestaurantsUseCase
    var restaurantsResponse = [DataEntity]()
    var error = ObservableProperty<String?>(value: nil)
    var reloadSubjectsData = ObservableProperty(value: false)
    private lazy var geocoder = CLGeocoder()
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?
    weak var delegate: HomePageViewModelDelegate?
    
    init(menuUseCase: MenuUseCase, restaurantsUseCase: RestaurantsUseCase) {
        self.menuUseCase = menuUseCase
        self.restaurantsUseCase = restaurantsUseCase
    }
    
    //MARK: - Public Methods
    func viewLoaded() {        
        fetchResturantList()
    }
    
    func fetchResturantList() {
        restaurantsUseCase.fetchResturantList(pinCode: "") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.restaurantsResponse = data
                self.reloadSubjectsData.value = true
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
    
    func getUserLocation() {
        checkLocationServices()
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        }
    }
    
    private func getUserReverseGeocode(longitude: Double, latitude: Double) {
        DispatchQueue.main.async {
            self.geocoder.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { [weak self] (placemarks, error) in
                
                guard let self = self else { return }
                
                if let error = error {
                    print(error)
                    return
                }
                guard let placemark = placemarks?.first else { return }
                var locationString = ""
                var areaName = ""
                if let thoroughfare = placemark.thoroughfare {
                    areaName = thoroughfare
                    locationString += thoroughfare + ", "
                }
                if let locality = placemark.locality {
                    locationString += locality + ", "
                }
                if let subLocality = placemark.subLocality {
                    locationString += subLocality + ", "
                }
                if let subThoroughfare = placemark.subThoroughfare {
                    locationString += subThoroughfare + ", "
                }
                if let administrativeArea = placemark.administrativeArea {
                    locationString += administrativeArea
                }
                print("Location: \(locationString)")
                self.delegate?.showLocationString(areaName: areaName, locationString: locationString)
            }
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            getLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            getLocation()
        case .restricted:
            break
        }
    }
    
    private func getLocation() {
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            guard let userLocation = locationManager.location else {
                return
            }
            print(userLocation.coordinate.latitude)
            print(userLocation.coordinate.longitude)
            let lat = userLocation.coordinate.latitude
            let long = userLocation.coordinate.longitude
            getUserReverseGeocode(longitude: long, latitude: lat)
        }
    }
    
    
}

// MARK: - Location Manager Delegate
extension HomeViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}

