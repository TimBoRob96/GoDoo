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
        TabView {
            
            NavigationView {
                

                    VStack {
                        Image("Godoo")
                            .padding()
                        NavigationLink(destination: LoadingLocationView(locationManager: locationManager, currentLocation: true)) {
//                            Button("Use Current Location") {
                                Text("Use Current Location")
                                //locationManager.requestLocation()
//                                print("preessed")
                            }
                            
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.roundedRectangle)
                            .foregroundColor(.cyan)
                            .padding()
                        
                        Text("Enter Location")
                        TextField("Placeholder", text: $userLocation)
                            .textFieldStyle(.roundedBorder)
                        NavigationLink(destination: LoadingLocationView(locationManager:  locationManager, currentLocation: false)) {
                            Text("Go")
                        }
                        
                        }
//                    }
//                }
                }
            
                .tabItem {
                    Image(systemName: "mappin.circle.fill")
                    Text("Words")
                }
            
            FavouritePlacesView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favourites")
                    
                }
            
        }
        
    }
        
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




