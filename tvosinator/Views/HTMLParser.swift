//
//  SwiftUIView.swift
//  tvosinator
//
//  Created by gebeto on 23.11.2021.
//

import SwiftUI
import SwiftSoup

struct FilmItem {
    var link: String;
    var title: String;
    var preview: String;
    var year: String?;
    var original: String?;
    
    init(block: Element) {
        self.link = try! block.select("a.short_title").attr("href");
        self.title = try! block.select("a.short_title").text();
        let src = try! block.select("img").attr("data-src");
        self.preview = "https://eneyida.tv" + src;
        self.year = try! block.select(".short_subtitle").text().components(separatedBy: " • ")[0];
        self.original = try! block.select(".short_subtitle").text().components(separatedBy: " • ")[1];
    }
}

class SimpleParser: ObservableObject {
    @Published var items: [FilmItem] = [];
    @Published var loading = false;
    
    func parse(query: String) {
        self.loading = true;
        var searchUrlGenerator = URLComponents(string: "https://eneyida.tv/index.php")!;
        searchUrlGenerator.queryItems = [
            URLQueryItem(name: "story", value: query),
            URLQueryItem(name: "do", value: "search"),
            URLQueryItem(name: "subaction", value: "search"),
        ];
        let url = searchUrlGenerator.url;

        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            guard let data = data else { return }
            let html = String(data: data, encoding: .utf8)!;
            let doc = try! SwiftSoup.parse(html);
            let elements = try! doc.select("article.short");
            let films = elements.map { FilmItem(block: $0)}
            print(films);
            DispatchQueue.main.async {
                self.items = films;
                self.loading = false;
            }
        }

        task.resume();
    }
}
