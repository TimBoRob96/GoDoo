//
//  LocationManager.swift
//  GoDooSUI
//
//  Created by Tim Roberts on 16/05/2023.
//

import Foundation
import CoreLocation
import CoreLocationUI

//MARK: - Current Location methods
//Using core loocation gets the user's current longitude and latitude

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    var located: CLLocation?
    @Published var lat: CLLocationDegrees?
    @Published var lon: CLLocationDegrees?
    @Published var requestedLocation = false
    @Published var hasFinishedLoading = false
    @Published var placemark: CLPlacemark?
    
    let geocoder = CLGeocoder()
    
    var userEnteredLocation: String?
    
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    //Location is requested here
    
    func resetLocation() {
        located = nil
        lat = nil
        lon = nil
        placemark = nil
        
    
    }
    
    func requestLocation() {
        requestedLocation = true
        manager.requestLocation()
        
    }
    
    //When the location has finised requesting and has updated successfully.
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            manager.stopUpdatingLocation()
            lat = location.coordinate.latitude
            lon = location.coordinate.longitude
            located = location
            
            hasFinishedLoading = true
            //print(lat)
            
        }
    }
    
    // here we can make changes based on whether the user has allowed location to be taken.
    
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
    
    func lookUpCurrentLocation() {
        // Use the last reported location.
        if let lastLocation = located {
            
            // Look up the location
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    self.placemark = firstLocation
                    
                }
                else {
                    // An error occurred during geocoding.
                    print("geocoding error: \(error!.localizedDescription)")
                }
            }
            )
        }
        else {
            print("No location provided for lookup")
        }
    }
    
}


//MARK: - Methods for Entered Location

extension LocationManager {
    
    func getCoordinate( addressString : String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    self.lat = location.coordinate.latitude
                    self.lon = location.coordinate.longitude
                    self.located = location
                    self.hasFinishedLoading = true
                    return
                }
            } else {
                print("error getting co-ordinates \(error!.localizedDescription)")
            }
            //completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
}
