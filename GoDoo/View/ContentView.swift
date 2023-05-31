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
                            .resizable()
                            .frame(width: 300,height: 300)
                            .padding(.vertical)
                            

                        NavigationLink(destination: KeywordListView(locationManager: locationManager, userEnteredLocation: nil, currentLocation: true)) {
                                Text("Use Current Location")

                            }
                            
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.roundedRectangle)
                            .foregroundColor(.cyan)
                            .padding()
                        

                        HStack {
                            
                            TextField("Enter a location", text: $userLocation)
                                .textFieldStyle(.roundedBorder)
                            NavigationLink(destination: KeywordListView(locationManager:  locationManager, userEnteredLocation: userLocation, currentLocation: false)) {
                                Text("Go")
                            } .buttonStyle(.borderedProminent)
                        }
                        .padding(.horizontal)
                        
                        }
                    .onAppear {
                        locationManager.hasFinishedLoading = false
                        locationManager.requestedLocation = false
                        userLocation = ""
                    }

                }
            
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




