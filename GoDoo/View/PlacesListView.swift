//
//  PlacesListView.swift
//  GoDooSUI
//
//  Created by Tim Roberts on 16/05/2023.
//

import SwiftUI
import CoreLocation

struct PlacesListView: View {
    
    @ObservedObject var placesManager = PlacesManager()

    
    let keyword: String
    let lat: CLLocationDegrees
    let lon: CLLocationDegrees
    
    
    var body: some View {
        NavigationView {
            
            List(placesManager.placesList) { place in
                VStack {
                    NavigationLink(place.placeName, destination: PlaceView())
                    HStack {
                        Text(place.placeName)
                        Spacer()
                        if place.rating != nil {
                            Text("\(place.rating!) stars")
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
