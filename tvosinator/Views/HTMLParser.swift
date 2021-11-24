//
//  SwiftUIView.swift
//  tvosinator
//
//  Created by gebeto on 23.11.2021.
//

import SwiftUI
import SwiftSoup

struct FilmItem {
    var href: String;
    var title: String;
    var preview: String;
}

class SimpleParser: ObservableObject {
    @Published var items: [String] = [];
    @Published var loading = false;
    
    func parse(query: String) {
        var host = URLComponents(string: "https://eneyida.tv/index.php")!;
        host.queryItems = [
            URLQueryItem(name: "story", value: query),
            URLQueryItem(name: "do", value: "search"),
            URLQueryItem(name: "subaction", value: "search"),
        ];
        let url = host.url!;
        
        if url == nil {
            loading = false;
            return
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let html = String(data: data, encoding: .utf8)!;
            print(html)
            
            let doc = try! SwiftSoup.parse(html);
            let elements = try! doc.select("article.short");
            let iss = elements.map { el in
                FilmItem(
                    href: try! el.select("a.short_title").attr("href"),
                    title: try! el.select("a.short_title").text(),
                    preview: try! el.select("img").attr("data-src")
                )
            }
            print(iss);
            self.items = [];
            self.loading = true;
        }

        task.resume()
    }
}
