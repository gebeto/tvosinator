//
//  FilmItemProtocol.swift
//  tvosinator
//
//  Created by gebeto on 24.11.2021.
//

import Foundation


protocol FilmItemProtocol {
    var link: String { get set };
    var title: String { get set };
    var preview: String { get set };
    var year: String? { get set };
    var original: String? { get set };
}

struct FilmItem : FilmItemProtocol {
    var link: String;
    var title: String;
    var preview: String;
    var year: String?;
    var original: String?;
}
