//
//  HomeParseView.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import SwiftUI


struct HomePageModel: Codable {
    let data: [FilmsSection]
    
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(HomePageModel.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
    
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}


class HomeParseViewDelegate: ParseNavigationDelegate {
    override func dictToObject(dict: [String : Any]) {
        if let formattedData = try? HomePageModel(dictionary: dict) {
            self.setResult(formattedData);
        }
    }
}


struct HomeParseView: ParseView {
    var navigationDelegate: ParseNavigationDelegate;
    var url: String;
    
    init(url: String, script: String, setFilmsSections: @escaping ([FilmsSection]) -> Void) {
        self.url = url;
        self.navigationDelegate = HomeParseViewDelegate(script: script, setResult: { result in
            if let data = result as? HomePageModel {
                setFilmsSections(data.data);
            }
        });
    }
}
