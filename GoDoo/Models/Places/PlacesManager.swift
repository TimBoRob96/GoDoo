//
//  PlacesManager.swift
//  GoDooSUI
//
//  Created by Tim Roberts on 16/05/2023.
//
import CoreLocation
import SwiftUI

class PlacesManager: ObservableObject{
    
    var hasFinishedLoading: Bool = false
    
    
    @Published var placesList = [Place]()
    
    let placesURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    let apiKey = K.apiKey
    
    func fetchPlaces(keyword: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let urlString = "\(placesURL)location=\(latitude),\(longitude)&radius=10000&key=\(apiKey)&keyword=\(keyword)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String)  {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {

                    print(error!)

                }
                
                if let safeData = data {

                    if let places = self.parseJson(safeData) {
                        
                        //return places
                        DispatchQueue.main.async {
                            self.placesList = places
                        }

                        //print(places)
                        //delegate?.didUpdatePlaces(places)
                        
                        //delegate?.didUpdateWeather(self, weather: weather)
                    }
                    //print(dataString!)
                    }
                    
                }
            task.resume()
            }
            
            
    }
    
    func parseJson(_ placesData: Data) -> [Place]? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(PlacesData.self, from: placesData)
            var places: [Place] = []
            for result in decodedData.results {
                
                let name = result.name
                let id = result.place_id
                let rating = result.rating
                let place = Place(id: id, placeName: name, rating: rating)
                //print(rating)
                
                places.append(place)

            }
            
            return places

            
        } catch {

            print(error)
            return nil
        }
        
        
    }
    
}
