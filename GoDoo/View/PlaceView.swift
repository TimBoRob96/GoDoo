//
//  PlaceView.swift
//  GoDooSUI
//
//  Created by Tim Roberts on 17/05/2023.
//

import SwiftUI

//This is the view for each individual place after selecting the location from placelist view
//To add a mapView to this!

struct PlaceView: View {
    
    let placeName: String
    let placeRating: Double?
    
    var rating: String {
        if placeRating != nil {
            return String(placeRating!) + "Stars"
        } else {
            return "No Rating"
        }
    }

    var body: some View {
        VStack {
            Text(placeName)
                .font(.largeTitle)
            Text(rating)
                .font(.headline)
        }
    }
}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceView(placeName: "Test", placeRating: 0.01)
    }
}
