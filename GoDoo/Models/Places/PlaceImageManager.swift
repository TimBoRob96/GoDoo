//
//  placeImageManager.swift
//  GoDoo
//
//  Created by Tim Roberts on 18/06/2023.
//

import Foundation
import SwiftUI

class PlaceImageManager: ObservableObject {
    
//    let imageID = "AZose0mzATIpuuWtyaffOUsS35A8mOoP0v0MYOqZ48l-kEmB2n87s8hYt45OtgdBueu7XcRYLPIsVN4IxTWKNIdfCNKAT2dFTsCw2EaoeGcaHhznzkcmGT3p7lsLroDcu55k_mI7W0x3Edq2WMmubTnKvlKfNDmbC3zUvZnkZf0fpBoY7eCV"
    
    var imageURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&key="
    
    
    @Published var placeImage: UIImage = UIImage(systemName: "xmark.circle")!
    
    func getPlaceImage(imageID: String) {
        let urlString = imageURL + K.apiKey + "&photo_reference=" + imageID
        let url = URL(string: urlString)!
        downloadImage(from: url)
        print(url)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.placeImage = UIImage(data: data)!
            }
        }
    }
    
}
