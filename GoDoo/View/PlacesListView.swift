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
    
    //Search variables
    let keyword: String
    let lat: CLLocationDegrees
    let lon: CLLocationDegrees
    let sliderRadius: Float
    
    var body: some View {
        
        VStack {
            //Button to access a mapView of all places
            NavigationLink("GoDoo Map", destination: PlaceListMapView(placesManager: placesManager))
            
            Spacer()

            List(
                //List of places found by API
                placesManager.placesList) { place in

                    VStack {
                        HStack {
                            NavigationLink(place.placeName, destination: PlaceView(place: place, region: placesManager.region ?? MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))))
                            Text(place.getLocation(latitude: lat, longitude: lon) + "km")
                        }
                    }
                }
            //Shows us how many places we found and a button for a random place selection
            
            Text("GoDoo Found \(placesManager.placesList.count) places!")
            
            if placesManager.randomPlace != nil {
                NavigationLink("Let GoDoo Choose!", destination: PlaceView(place: placesManager.randomPlace!, region: placesManager.region ?? MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))))
                    .buttonStyle(.borderedProminent)
                Spacer()
            }
        }
        //Actions run on app appearing, this is where we call the API
        .onAppear {
        
            
            if placesManager.placesList.count < 1 {
                placesManager.fetchPlaces(keyword: keyword, latitude: lat, longitude: lon, sliderRadius: sliderRadius)
            } else {
                placesManager.selectRandomPlace(places: placesManager.placesList)
            }

        }
        //Setting the title to the keyword
        .navigationBarTitle(keyword)
    }
    
}


struct PlacesListView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesListView(keyword: "Test", lat: CLLocationDegrees(0), lon: CLLocationDegrees(0), sliderRadius: 1)
    }
}
