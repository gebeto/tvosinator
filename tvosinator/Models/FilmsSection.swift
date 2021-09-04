//
//  FilmsSection.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import Foundation


struct FilmsSection: Codable {
    let title: String?
    let films: [Film]
    
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(FilmsSection.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
    
    init(title: String, films: [Film]) {
        self.title = title;
        self.films = films;
    }
    
    private enum CodingKeys: String, CodingKey {
        case title = "title", films = "films"
    }
}
