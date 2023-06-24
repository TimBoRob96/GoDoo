//
//  PlacesModel.swift
//  GoDoo
//
//  Created by Tim Roberts on 10/05/2023.
//

import Foundation
import CoreLocation
import SwiftUI

//Place datatype

struct Place: Identifiable {
    
    var id: String
    let placeName: String
    let rating: Double?
    let open: Bool?
    
    let photoRef: String?
    
    let lat: Float
    let lon: Float
    
    var openColour: Color {
        switch open {
        case true:
            return Color.green
        case false:
            return Color.red
        default:
            return Color.black
        }
    }
    
    
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
    
    
}
