//
//  FavouritePlacesView.swift
//  GoDoo
//
//  Created by Tim Roberts on 27/05/2023.
//

import SwiftUI

struct FavouritePlacesView: View {
    
    @StateObject var favouriteManager = FavouritePlaces()
    @StateObject var placesManager = PlacesManager()
    var body: some View {
        NavigationView {
            VStack {
                Text("FAVOURITE PLACES")
                    .font(.largeTitle)
                
                List { ForEach(favouriteManager.favourites) { favourite in
                    NavigationLink(favourite.name, destination: favouritePlaceView(placesManager: placesManager, place_id: favourite.id))
                    
                    //Text(favourite.name)
                }
                .onDelete { indexSet in
                    favouriteManager.favourites.remove(atOffsets: indexSet)
                    favouriteManager.saveFavourites()
                }
                }
                
            }
        }
        
        .onAppear {
            favouriteManager.loadFavourites()
            placesManager.favouritePlace = nil
            
        }
    }
}

struct FavouritePlacesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritePlacesView()
    }
}
