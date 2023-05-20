//
//  LocationManager.swift
//  GoDooSUI
//
//  Created by Tim Roberts on 16/05/2023.
//

import Foundation
import CoreLocation
import CoreLocationUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    @Published var lat: CLLocationDegrees?
    @Published var lon: CLLocationDegrees?
    @Published var requestedLocation = false
    @Published var hasFinishedLoading = false

    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        requestedLocation = true
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            manager.stopUpdatingLocation()
            lat = location.coordinate.latitude
            lon = location.coordinate.longitude
            hasFinishedLoading = true
            print(lat)
            ////////////////////print(String(lat))
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .authorizedWhenInUse:
            authorizationStatus = .authorizedWhenInUse
            
        case .restricted:
            authorizationStatus = .restricted
            break
            
        case .denied:
            authorizationStatus = .denied
            break
            case .notDetermined:
            authorizationStatus = .notDetermined
                manager.requestWhenInUseAuthorization()
                break
            
            default:
                break
        }
        

    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

