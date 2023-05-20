//
//  PlacesListView.swift
//  GoDooSUI
//
//  Created by Tim Roberts on 16/05/2023.
//

import SwiftUI
import CoreLocation

//This is the Place List view, after requesting locations from the Api the list of places is returned showing the Name and rating of the place.

struct PlacesListView: View {
    
    @ObservedObject var placesManager = PlacesManager()
    
    
    let keyword: String
    let lat: CLLocationDegrees
    let lon: CLLocationDegrees
    
    
    var body: some View {
        NavigationView {
            
            List(placesManager.placesList) { place in
                VStack {
                    
                    HStack {
                        NavigationLink(place.placeName, destination: PlaceView(placeName: place.placeName, placeRating: place.rating))
                        if place.rating != nil {
                            Text(String(place.rating!) + "Stars")
                        }
                    }
                }
            }
            
        }
        .onAppear {
            
            placesManager.fetchPlaces(keyword: keyword, latitude: lat, longitude: lon)
            
        }
        .navigationBarTitle(keyword)
    }
    
}

struct PlacesListView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesListView(keyword: "walk", lat: CLLocationDegrees(), lon: CLLocationDegrees())
    }
}
