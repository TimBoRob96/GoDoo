//
//  FavouritePlacesView.swift
//  GoDoo
//
//  Created by Tim Roberts on 27/05/2023.
//

import SwiftUI

struct FavouritePlacesView: View {
    
    @StateObject var favouriteManager = FavouritePlaces()
    
    var body: some View {
        VStack {
            Text("FAVOURITE PLACES")
                .font(.largeTitle)
            
            List { ForEach(favouriteManager.favourites) { favourite in
                Text(favourite.name)
            }
            }
            
        }
        
        .onAppear {
            favouriteManager.loadFavourites()
            
        }
    }
}

struct FavouritePlacesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritePlacesView()
    }
}
