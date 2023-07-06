//
//  CoinFlipView.swift
//  GoDoo
//
//  Created by Tim Roberts on 02/07/2023.
//

import SwiftUI
import MapKit

enum CoinState {
    case map, image, rating
}

struct CoinFlipView: View {
    
    let durationAndDelay: CGFloat = 0.3
    
    @State var isFlipped = false
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var ratingDegree = -90.0
    
    let place: Place
    @ObservedObject var placeImageManager: PlaceImageManager
    
    func flipCoin () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
    
    var body: some View {
        ZStack {
            MapView(degree: $frontDegree, place: place)
            ImageView(degree: $backDegree, place: place, placeImageManager: placeImageManager)
        }
        .onTapGesture {
            flipCoin()
        }
    }
}

struct MapView: View {
    @Binding var degree: Double
    
    let place: Place
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    
    var body: some View {

//            Map(coordinateRegion: $region)
//                .frame(width: 400,height: 400)
//                .clipShape(Circle())
        //}
            Map(coordinateRegion: $region, annotationItems: [place]) { placeMark in
                MapMarker(coordinate: placeMark.coordinate)
                
            }
            
            .allowsHitTesting(false)
            .frame(width: 300, height: 300,alignment: .center)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay(Circle().stroke(place.openColour, lineWidth: 5))
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
            .onAppear {
                region.center = CLLocationCoordinate2D(latitude: place.latComp, longitude: place.lonComp)
            }
            
    }
}

struct ImageView: View {
    @Binding var degree: Double
    let place: Place
    @ObservedObject var placeImageManager: PlaceImageManager
    
    var body: some View {
        
                                Image(uiImage: placeImageManager.placeImage)
                                    .frame(width: 300, height: 300,alignment: .center)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(place.openColour, lineWidth: 5))
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
//        Circle()
//            .foregroundColor(.blue)
//            .frame(width: 400,height: 400)
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct RatingView: View {
    var body: some View {
        Circle()
            .foregroundColor(.red)
            .frame(width: 200,height: 200)
    }
}

//struct CoinFlipView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoinFlipView()
//    }
//}
