//
//  Keyword.swift
//  GoDooSUI
//
//  Created by Tim Roberts on 16/05/2023.
//

import Foundation

//This has the list of keywords that are default and also the struct of a keyword datatype

class KeywordManager: ObservableObject {
    @Published var keywords = [Keyword(text: "Walk", id: "1"), Keyword(text: "Swim", id: "2"),Keyword(text: "Cafe", id: "3")]
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Keywords.plist")
    
    func saveKeywords() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(keywords)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding \(error)")
        }
    }
    
    func loadKeywords() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                keywords = try decoder.decode([Keyword].self, from: data)
            } catch {
                print("error decoding \(error)")
            }
        }
        
    }
    
}

struct Keyword: Identifiable, Codable {
    let text: String
    let id: String
}
