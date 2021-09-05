//
//  HomeParseView.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import SwiftUI


struct SearchPageModel: Codable {
    let data: [Film]
    
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(SearchPageModel.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
    
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}


class SearchParseViewDelegate: ParseNavigationDelegate {
    override func dictToObject(dict: [String : Any]) {
        if let formattedData = try? SearchPageModel(dictionary: dict) {
            self.setResult(formattedData);
        }
    }
}


struct SearchParseView: ParseView {
    var navigationDelegate: ParseNavigationDelegate;
    var url: String;
    
    init(url: String, script: String, setFilms: @escaping ([Film]) -> Void) {
        self.url = url;
        self.navigationDelegate = SearchParseViewDelegate(script: script, setResult: { result in
            if let data = result as? SearchPageModel {
                setFilms(data.data);
            }
        });
    }
}
