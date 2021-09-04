//
//  Film.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import Foundation


struct Film: Codable {
    let title: String
    let preview: String
    let link: String
    
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(Film.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
    
    init(title: String, preview: String, link: String) {
        self.title = title;
        self.preview = preview;
        self.link = link;
    }
    
    private enum CodingKeys: String, CodingKey {
        case title = "title", preview = "preview", link = "link"
    }
}
