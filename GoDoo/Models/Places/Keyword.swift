//
//  Keyword.swift
//  GoDooSUI
//
//  Created by Tim Roberts on 16/05/2023.
//

import Foundation

class KeywordManager: ObservableObject {
    @Published var Keywords = [Keyword(text: "cafe", id: "11"), Keyword(text: "tea", id: "15"),Keyword(text: "castle", id: "24"),Keyword(text: "Walk", id: "3"),Keyword(text: "Waterfall", id: "9"),Keyword(text: "Bakery", id: "26")]
}

struct Keyword: Identifiable {
    let text: String
    let id: String
}
