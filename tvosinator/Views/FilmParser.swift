//
//  SwiftUIView.swift
//  tvosinator
//
//  Created by gebeto on 23.11.2021.
//

import SwiftUI
import SwiftSoup

struct FilmFile {
    var origin: String;
    var m3u8: String?;
}

class FilmParser: ObservableObject {
    @Published var film: FilmFile?;
    @Published var loading = false;
    
    func fetchm3u8Link(link: String) {
        let url = URL(string: link);

        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            guard let data = data else { return }
            let html = String(data: data, encoding: .utf8)!;
            let range = NSRange(location: 0, length: html.utf16.count);
            let regex = try! NSRegularExpression(pattern: "file:\"(.+)\"");
            let matchRange: NSRange? = regex.matches(in: html, options: [], range: range).first!.range(at: 1);
            let substringRange = Range(matchRange!, in: html)!
            let capture = String(html[substringRange]);
            DispatchQueue.main.async {
                self.film = FilmFile(origin: link, m3u8: capture);
                self.loading = false;
            }
        }
        
        task.resume();
    }
    
    func parse(url: String) {
        self.loading = true;
        let url = URL(string: url);

        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            guard let data = data else { return }
            let html = String(data: data, encoding: .utf8)!;
            let doc = try! SwiftSoup.parse(html);
            let element = try! doc.select("iframe").first()!;
            let link = try! element.attr("src");
            self.fetchm3u8Link(link: link);
        }

        task.resume();
    }
}
