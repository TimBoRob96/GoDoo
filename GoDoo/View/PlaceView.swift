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
    
    let place: Place
    @ObservedObject var favouriteManager = FavouritePlaces()
    @ObservedObject var placeImageManager = PlaceImageManager()
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    
    
    var rating: String {
        if place.rating != nil {
            return String(place.rating!) + "Stars"
        } else {
            return "No Rating"
        }
    }
    
    var body: some View {
        VStack {
            Text(place.placeName)
                .font(.largeTitle)
            Text(rating)
                .font(.headline)
            if place.open != nil {
                Text(place.open! ? "Open Now" : "Closed Right Now").foregroundColor(place.openColour)
            }
            
            ScrollView(.horizontal) {
                HStack {
                    Spacer(minLength: 100)
                    
                    Image(uiImage: placeImageManager.placeImage)
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(place.openColour, lineWidth: 5))
                        
                    Spacer(minLength: 200)
                    
                    Map(coordinateRegion: $region, annotationItems: [place]) { placeMark in
                        MapMarker(coordinate: placeMark.coordinate)
                        
                    }
                    .frame(width: 300, height: 300)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(Circle().stroke(place.openColour, lineWidth: 5))
                    Spacer(minLength: 100)

                }
            }
            
            HStack{
                Button("Directions") {
                    let url = URL(string: "maps://?saddr=&daddr=\(place.latComp),\(place.lonComp)")
                    if UIApplication.shared.canOpenURL(url!) {
                        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                    }
                }
                .buttonStyle(.borderedProminent)
                
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
                        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.latComp, longitude: place.lonComp), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

                            let newFavourite = Favourite(name: place.placeName, id: place.id)
                            favouriteManager.favourites.append(newFavourite)
                        favouriteManager.saveFavourites()
                        favouriteManager.loadFavourites()

                    }
                    .buttonStyle(.borderedProminent)
                    
                }
                
            }
        }
        .onAppear {
            
            region.center = CLLocationCoordinate2D(latitude: place.latComp, longitude: place.lonComp)
            favouriteManager.loadFavourites()
            if place.photoRef != nil {
                placeImageManager.getPlaceImage(imageID: place.photoRef!)
            }

        }
    }
}

struct favouritePlaceView: View {
    
    @ObservedObject var placesManager: PlacesManager
    
    let place_id: String

    var body: some View {
        
        if placesManager.favouritePlace != nil {
            if placesManager.favouritePlace?.id == place_id {
                PlaceView(place: placesManager.favouritePlace!)
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





//struct PlaceView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceView(placeName: "Test", placeRating: 0.01)
//    }
//}
