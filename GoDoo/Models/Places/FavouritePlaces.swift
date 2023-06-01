//
//  FavouritePlaces.swift
//  GoDoo
//
//  Created by Tim Roberts on 27/05/2023.
//

import Foundation

class FavouritePlaces: ObservableObject {
    
    @Published var favourites: [Favourite] = []
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Favourites.plist")
    
    func saveFavourites() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(favourites)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding \(error)")
        }
    }
    func loadFavourites() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                favourites = try decoder.decode([Favourite].self, from: data)
                
            } catch {
                print("error decoding \(error)")
            }
        }
    }
}

struct Favourite: Codable, Identifiable {
    let name: String
    let id: String
}
