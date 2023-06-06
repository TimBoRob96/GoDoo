//
//  PlacesModel.swift
//  GoDoo
//
//  Created by Tim Roberts on 10/05/2023.
//

import Foundation
import CoreLocation

//Place datatype

struct Place: Identifiable {
    
    var id: String
    let placeName: String
    let rating: Double?
    let lat: Float
    let lon: Float
    
    
    var latComp: CLLocationDegrees {
        return CLLocationDegrees(lat)
    }
    var lonComp: CLLocationDegrees {
        return CLLocationDegrees(lon)
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latComp, longitude: lonComp)
    }
    
    
    func getLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> String {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        let placeLocation = CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        
        let distance = location.distance(from: placeLocation)
        
        return String(format: "%.2f" ,distance/1000)
    }
    
    //=acos(sin(lat1)*sin(lat2)+cos(lat1)*cos(lat2)*cos(lon2-lon1))*6371
    
}
