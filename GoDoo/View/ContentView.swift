//
//  ContentView.swift
//  GoDooSwiftUI
//
//  Created by Tim Roberts on 16/05/2023.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        
        NavigationView {
            
            if locationManager.requestedLocation {
                LoadingLocationView(locationManager: locationManager)
                
                if locationManager.hasFinishedLoading {
                    
                    KeywordListView(locationManager: locationManager)
                }
                


            } else {
                VStack {
                    Image("Godoo")
                        .padding()
                    
                    Button("Use Current Location") {
                        locationManager.requestLocation()
                        print("preessed")
                    }
                    
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                    .foregroundColor(.cyan)

                }
            }

            }
            
        }
            

    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




