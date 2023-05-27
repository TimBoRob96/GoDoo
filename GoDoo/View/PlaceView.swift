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
    var favouriteManager = FavouritePlaces()
    
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
            
            
            Map(coordinateRegion: $region)
                .frame(width: 300, height: 300)
                .padding()
            Button("Favourite") {
                //region.center = CLLocationCoordinate2D(latitude: place.latComp, longitude: place.lonComp)
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.latComp, longitude: place.lonComp), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                
                if favouriteManager.favourites.contains(where: {favourite in favourite.id == place.id}) {
                    print("already favourited")
                } else {
                    let newFavourite = Favourite(name: place.placeName, id: place.id)
                    
                    
                    
                    favouriteManager.favourites.append(newFavourite)
                    favouriteManager.saveFavourites()
                }
                

                
            }
            .buttonStyle(.borderedProminent)
            
        }
        .onAppear {
            //region =
            region.center = CLLocationCoordinate2D(latitude: place.latComp, longitude: place.lonComp)
            favouriteManager.loadFavourites()
        }
        
    }
    
}





//struct PlaceView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceView(placeName: "Test", placeRating: 0.01)
//    }
//}
