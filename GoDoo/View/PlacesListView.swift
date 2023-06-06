//
//  PlacesListView.swift
//  GoDooSUI
//
//  Created by Tim Roberts on 16/05/2023.
//

import SwiftUI
import CoreLocation
import MapKit

//This is the Place List view, after requesting locations from the Api the list of places is returned showing the Name and rating of the place.

struct PlacesListView: View {
    
    @StateObject var placesManager = PlacesManager()
    
    
    let keyword: String
    let lat: CLLocationDegrees
    let lon: CLLocationDegrees
    let sliderRadius: Float
    
    //@State var randomPlace: Place?
    
    var body: some View {
        
        VStack {
            
            NavigationLink("GoDoo Map", destination: PlaceListMapView(placesManager: placesManager))
            
            Spacer()

            List(
                
                
                placesManager.placesList) { place in
                    
                    
                    VStack {
                        HStack {
                            NavigationLink(place.placeName, destination: PlaceView(place: place))
                            Text(place.getLocation(latitude: lat, longitude: lon) + "km")
                        }
                    }
                }
                .onAppear{ print(placesManager.placesList.count) }
            Text("GoDoo Found \(placesManager.placesList.count) places!")
            if placesManager.randomPlace != nil {
                NavigationLink("Let GoDoo Choose!", destination: PlaceView(place: placesManager.randomPlace!))
                    .buttonStyle(.borderedProminent)
                Spacer()
            }
        }
        .onAppear {
            
            
            if placesManager.placesList.count < 1 {
                placesManager.fetchPlaces(keyword: keyword, latitude: lat, longitude: lon, sliderRadius: sliderRadius)
            } else {
                placesManager.selectRandomPlace(places: placesManager.placesList)
            }

        }
//        .onChange(of: placesManager.placesList.count) { newValue in
//            if newValue > 0 {
//                print(newValue)
//                //randomPlace = placesManager.selectRandomPlace()
//            }
//
//        }

        .navigationBarTitle(keyword)
    }
    
}


//struct PlacesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlacesListView(keyword: "walk", lat: CLLocationDegrees(), lon: CLLocationDegrees())
//    }
//}
