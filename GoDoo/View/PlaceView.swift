//
//  PlaceView.swift
//  GoDooSUI
//
//  Created by Tim Roberts on 17/05/2023.
//

import SwiftUI
import CoreLocation
import MapKit

//This is the view for each individual place after selecting the location from placelist view
//To add a mapView to this!

struct PlaceView: View {
    
    //Setting place
    let place: Place
    
    //Manager objects
    @ObservedObject var favouriteManager = FavouritePlaces()
    @ObservedObject var placeImageManager = PlaceImageManager()
    
    //Region
    @State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    
    //Place rating - To Review?
    var rating: String {
        if place.rating != nil {
            return String(place.rating!)
        } else {
            return "?"
        }
    }
    
    var body: some View {
        VStack {
            //Place Name and open/closed text
            Text(place.placeName)
                .font(.largeTitle)
            if place.open != nil {
                Text(place.open! ? "Open Now" : "Closed Right Now").foregroundColor(place.openColour)
            }
            
            CoinFlipView(place: place, placeImageManager: placeImageManager)
            
            
            //Button for opening the maps app for directions.
            HStack{
                Button("Directions") {
                    let url = URL(string: "maps://?saddr=&daddr=\(place.latComp),\(place.lonComp)")
                    if UIApplication.shared.canOpenURL(url!) {
                        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                    }
                }
                .buttonStyle(.borderedProminent)
                
                
                //Favourite / Unfavourite button
                if favouriteManager.favourites.contains(where: {favourite in favourite.id == place.id}) {
                    
                    Button("UnFavourite") {

                        favouriteManager.favourites.removeAll { favPlace in
                            return favPlace.id == place.id
                          }
                        favouriteManager.saveFavourites()
                        favouriteManager.loadFavourites()
                    }
                    .buttonStyle(.borderedProminent)
                } else {

                    Button("Favourite") {
                        //region.center = CLLocationCoordinate2D(latitude: place.latComp, longitude: place.lonComp)
//                        region = MKCoordinateRegion(center: place.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                        //region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.latComp, longitude: place.lonComp), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

                            let newFavourite = Favourite(name: place.placeName, id: place.id)
                            favouriteManager.favourites.append(newFavourite)
                        favouriteManager.saveFavourites()
                        favouriteManager.loadFavourites()

                    }
                    .buttonStyle(.borderedProminent)
                    
                }
                
            }
        }
        
        //On appearance of the screen we load the placeImage and we load our favourites.
        .onAppear {
            
            //region.center = CLLocationCoordinate2D(latitude: place.latComp, longitude: place.lonComp)
            favouriteManager.loadFavourites()
            if place.photoRef != nil {
                placeImageManager.getPlaceImage(imageID: place.photoRef!)
            }

        }
    }
}

//Our favourite placeview loads a placeview but calls the placeID api to get the details instead of the list of nearby places api

struct favouritePlaceView: View {
    
    @ObservedObject var placesManager: PlacesManager
    
    let place_id: String

    var body: some View {
        
        if placesManager.favouritePlace != nil {
            if placesManager.favouritePlace?.id == place_id {
                PlaceView(place: placesManager.favouritePlace!)//, region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
            }
            else {
                ProgressView()
                    .onAppear {
                        placesManager.favouritePlace = nil
                    }
            }
            
        } else {
            ProgressView()
                .onAppear {
                    placesManager.fetchPlaceDetails(place_id: place_id)
                }
        }

    }
    
}




//
//struct PlaceView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceView(placeName: "Test", placeRating: 0.01)
//    }
//}
