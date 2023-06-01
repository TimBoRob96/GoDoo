//
//  LoadingView.swift
//  GoDooSUI
//
//  Created by Tim Roberts on 20/05/2023.
//

import SwiftUI


//This is the loading view for the location request
//Would also like to incorporate this or similiar when the api request is in progress.

struct LoadingLocationView: View {
    
    @ObservedObject var locationManager: LocationManager
    let currentLocation: Bool
    let userEnteredLocation: String?
    
    var body: some View {
        
        VStack {
            Text("Finding your location...")
            ProgressView()
            
        }
        .onAppear {
            if currentLocation {
                locationManager.requestLocation()
                
            }
            
            else {
                print("usergeneratedlocation")
                locationManager.getCoordinate(addressString: userEnteredLocation ?? "Africa")
            }
        }
        
    }
}


//struct LoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingView(locationManager: <#LocationManager#>)
//    }
//}
