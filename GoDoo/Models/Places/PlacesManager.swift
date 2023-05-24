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
    
    let placesURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    let apiKey = K.apiKey
    
    func fetchPlaces(keyword: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, sliderRadius: Float) {
        
        let radius = Int(round(sliderRadius * 1000))
        
        let urlString = "\(placesURL)location=\(latitude),\(longitude)&radius=\(radius)&key=\(apiKey)&keyword=\(keyword)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    //Starts the URL Session and performs the api request.
    
    func performRequest(with urlString: String)  {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    
                    print(error!)
                    
                }
                
                if let safeData = data {
                    
                    if let places = self.parseJson(safeData) {
                        
                        DispatchQueue.main.async {
                            self.placesList = places
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
    
    //When the session has retrieved the JSON data it is decoded using this method
    
    func parseJson(_ placesData: Data) -> [Place]? {
        
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
