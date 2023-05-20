//
//  PlacesData.swift
//  GoDoo
//
//  Created by Tim Roberts on 10/05/2023.
//

import Foundation

struct PlacesData: Decodable {
    
    let results: [Result]
    
}

struct Result: Decodable {
    
    let name: String
    let place_id: String
    let rating: Double?
    //let types: String
    //let type: String
}
