//
//  KeywordListView.swift
//  GoDooSUI
//
//  Created by Tim Roberts on 16/05/2023.
//

import SwiftUI
import CoreLocation

//list of keywords that the user has access to stored in the Keyword.swift file.,
// These are displayed in a table for the user to select from which then requests the places from the placeManager and progresses to the Place List View
//user is also able to add their own keywords but they disappear whent he app is reloaded currently.

struct KeywordListView: View {
    
    @ObservedObject var locationManager: LocationManager
    @StateObject var keywordManager = KeywordManager()
    @State private var newKeyword: String = ""
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("Look at these spots!")
                TextField("Placeholder", text: $newKeyword)
                Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                    keywordManager.keywords.append(Keyword(text: newKeyword, id: "keyword\(newKeyword)"))
                    keywordManager.saveKeywords()
                    newKeyword = ""
                }
                
                //MARK: - List View for Keywords
                
                List { ForEach(keywordManager.keywords) { keyword in
                    
                    NavigationLink(destination: PlacesListView(keyword: keyword.text, lat: locationManager.lat!, lon: locationManager.lon!)) {
                        Text(keyword.text)
                        
                    }
                    
                    
                }
                    
                .onDelete { indexSet in
                    keywordManager.keywords.remove(atOffsets: indexSet)
                    keywordManager.saveKeywords()
                }
                    
                }
            }.onAppear {
                keywordManager.loadKeywords()
            }
            
        }
        
    }
}

//struct KeywordListView_Previews: PreviewProvider {
//    static var previews: some View {
//        KeywordListView(locationManager: LocationManager(), keywordManager: KeywordManager(), newKeyword: "")
//    }
//}
