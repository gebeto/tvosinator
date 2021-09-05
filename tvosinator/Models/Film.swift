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
    let year: String?
    let original: String?
    
    init(title: String, preview: String, link: String, year: String? = nil, original: String? = nil) {
        self.title = title;
        self.preview = preview;
        self.link = link;
        self.year = year;
        self.original = original;
    }
}
