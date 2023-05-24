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
    
}
