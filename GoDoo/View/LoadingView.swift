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
    
    var body: some View {
        
        if locationManager.hasFinishedLoading {
            KeywordListView(locationManager: locationManager)
        }   else {
            VStack {
                Text("Finding your location...")
                ProgressView()
                
            }
        }
    }
}


//struct LoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingView(locationManager: <#LocationManager#>)
//    }
//}
