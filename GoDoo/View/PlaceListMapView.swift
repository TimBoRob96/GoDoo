//
//  PlaceListMapView.swift
//  GoDoo
//
//  Created by Tim Roberts on 06/06/2023.
//

import SwiftUI
import MapKit

struct PlaceListMapView: View {
    
    //Loading the placesmanager and setting the map region
    @ObservedObject var placesManager: PlacesManager
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        //Title
        Text("Map of Places")
        //button to centre map - to review!
        Button("Go") {
            region.center = placesManager.coordinate!
        }
            .onAppear {
                //region = placesManager.region!
                region.center = placesManager.coordinate!
            }
        
        //Handling a nil region - To review?
        if placesManager.region != nil {
            
            //Adding the placemarks for each place
            Map(coordinateRegion: $region, annotationItems: placesManager.placesList) { placeMark in
                
                MapAnnotation(coordinate: placeMark.coordinate) {
                  NavigationLink {
                      PlaceView(place: placeMark, region: placesManager.region ?? MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
                  } label: {
                    PlaceAnnotationView(title: placeMark.placeName)
                  }
                }
                //MapMarker(coordinate: placeMark.coordinate)
                //Text(placeMark.placeName)
                
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

// code sourced from https://kristaps.me/blog/swiftui-map-annotations/
// To customize later on but this was exactly what I was looking for!


struct PlaceAnnotationView: View {
  @State private var showTitle = true
  
  let title: String
  
  var body: some View {
    VStack(spacing: 0) {
      Text(title)
        .font(.callout)
        .padding(5)
        .background(Color(.white))
        .cornerRadius(10)
        //.opacity(showTitle ? 0 : 1)
      
      Image(systemName: "mappin.circle.fill")
        .font(.title)
        .foregroundColor(.red)
      
      Image(systemName: "arrowtriangle.down.fill")
        .font(.caption)
        .foregroundColor(.red)
        .offset(x: 0, y: -5)
    }
//    .onTapGesture {
//      withAnimation(.easeInOut) {
//        showTitle.toggle()
//      }
//    }
  }
}
