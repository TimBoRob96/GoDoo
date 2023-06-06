//
//  PlacesManager.swift
//  GoDooSUI
//
//  Created by Tim Roberts on 16/05/2023.
//
import CoreLocation
import SwiftUI
import MapKit

//The places manager requests a list of nearby places based on a co-ordinate provided by the user's current location.

class PlacesManager: ObservableObject{
    
    var hasFinishedLoading: Bool = false
    @Published var placesList = [Place]()
    @Published var randomPlace: Place?
    @Published var favouritePlace: Place?
    @Published var region: MKCoordinateRegion?
    @Published var coordinate: CLLocationCoordinate2D?
    
    //let placesURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    let placesURL = "https://maps.googleapis.com/maps/api/place/"
    let apiKey = K.apiKey
    
    func selectRandomPlace(places: [Place]) {
        
        if placesList.count > 1 {
            let randomNumber = Int.random(in: 0...places.count-1)
            randomPlace = places[randomNumber]
        }

    }
    
    func fetchPlaces(keyword: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, sliderRadius: Float) {
        let radius = Int(round(sliderRadius * 1000))
        let nearBy = "nearbysearch"
        let nearByURL = placesURL + nearBy
        let urlString = "\(nearByURL)/json?location=\(latitude),\(longitude)&radius=\(radius)&key=\(apiKey)&keyword=\(keyword)"
        
        let radiusDelta = Double(radius)/110.0
        
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: radiusDelta, longitudeDelta: radiusDelta))
        
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        //print(urlString)
        performRequest(with: urlString)
        
        
    }
    
    //Starts the URL Session and performs the api request.
    
    func performRequest(with urlString: String)  {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("error getting nearby places\(error!)")
                }
                if let safeData = data {
                    if let places = self.parsePlacesJson(safeData) {
                        DispatchQueue.main.async {
                            self.placesList = places
                            self.selectRandomPlace(places: places)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    //When the session has retrieved the JSON data it is decoded using this method
    
    func parsePlacesJson(_ placesData: Data) -> [Place]? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(PlacesData.self, from: placesData)
            var places: [Place] = []
            for result in decodedData.results {
                let name = result.name
                let id = result.place_id
                let rating = result.rating
                let lat = result.geometry.location.lat
                let lon = result.geometry.location.lng
                let place = Place(id: id, placeName: name, rating: rating, lat: lat, lon: lon)
                places.append(place)
            }
            return places
        } catch {
            print(error)
            return nil
        }
    }
    
}

//MARK: - Place Details

extension PlacesManager {
    
    func fetchPlaceDetails(place_id: String) {
        let details = "details"
        let detailsURL = placesURL + details
        let urlString = "\(detailsURL)/json?place_id=\(place_id)&key=\(apiKey)"
        performDetailsRequest(with: urlString)
    }
    func performDetailsRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("error requesting places details\(error!.localizedDescription)")
                }
                if let safeData = data {
                    
                    if let place = self.parseDetailsJson(safeData) {
                        self.favouritePlace = place
                        //completionHandler(place) = place
                        //print(place)
                        //How to get this to return the place!!
                    }
                }
            }
            task.resume()
        }
    }
    func parseDetailsJson(_ placeData: Data) -> Place? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PlaceData.self, from: placeData)
            let result = decodedData.result
            let name = result.name
            let id = result.place_id
            let rating = result.rating
            let lat = result.geometry.location.lat
            let lon = result.geometry.location.lng
            let place = Place(id: id, placeName: name, rating: rating, lat: lat, lon: lon)
            return place
        } catch {
            print(error)
            return nil
        }
    }
}
