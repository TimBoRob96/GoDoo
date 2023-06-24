//
//  ContentView.swift
//  GoDooSwiftUI
//
//  Created by Tim Roberts on 16/05/2023.
//

import SwiftUI
import CoreLocation

//This is the start screen which initializes the location manager, currently the user only has an option to request their current location.
// In the future be able to search locations.

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    @State var userLocation = ""
    
    var body: some View {
        
        // Our Tabs are GoDoo & Favourites
        TabView {
            // Top Level Navigation View, all our views are loaded on top of this!
            NavigationView {
                
                VStack {
                    
                    //Logo
                    Image("Godoo")
                        .resizable()
                        .frame(width: 300,height: 300)
                        .padding(.vertical)
                    
                     // Use Current Location button here
                    NavigationLink(destination: KeywordListView(locationManager: locationManager, userEnteredLocation: nil, currentLocation: true)) {
                        Text("Use Current Location")
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                    .foregroundColor(.cyan)
                    .padding()
                    
                    //Here we can type in a custom location into a text field
                    HStack {
                        TextField("Enter a location", text: $userLocation)
                            .textFieldStyle(.roundedBorder)
                        NavigationLink(destination: KeywordListView(locationManager:  locationManager, userEnteredLocation: userLocation, currentLocation: false)) {
                            Text("Go")
                        } .buttonStyle(.borderedProminent)
                    }
                    .padding(.horizontal)
                    
                    //On appearance of the start screen, called when user starts app and goes back to the first screen.
                }
                .onAppear {
                    locationManager.hasFinishedLoading = false
                    locationManager.requestedLocation = false
                    userLocation = ""
                    locationManager.resetLocation()
                    print("cont")
                }
            }
            //Tab menu at bottom of screen
            .tabItem {
                Image(systemName: "mappin.circle.fill")
                Text("GoDoo!")
            }
            FavouritePlacesView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Saved Places")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




