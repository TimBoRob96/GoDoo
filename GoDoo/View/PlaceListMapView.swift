//
//  PlaceListMapView.swift
//  GoDoo
//
//  Created by Tim Roberts on 06/06/2023.
//

import SwiftUI
import MapKit

struct PlaceListMapView: View {
    
    @ObservedObject var placesManager: PlacesManager
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        Text("Map of Places")
        Button("Go") {
            region.center = placesManager.coordinate!
        }
            .onAppear {
                //region = placesManager.region!
                region.center = placesManager.coordinate!
            }
        
        if placesManager.region != nil {
            Map(coordinateRegion: $region, annotationItems: placesManager.placesList) { placeMark in
                MapMarker(coordinate: placeMark.coordinate)
                
            }            .onAppear {
                //region = placesManager.region!
                region.center = placesManager.coordinate!
            }
        }
        

    }
}

//struct PlaceListMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceListMapView()
//    }
//}
