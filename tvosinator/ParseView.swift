//
//  ParseView.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import Foundation
import SwiftUI
import WebKit


struct Film: Codable {
    let title: String?
    let preview: String?
    
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(Film.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
    
    private enum CodingKeys: String, CodingKey {
        case title = "title", preview = "preview"
    }
}


class ParseNavigationDelegate: NSObject, WKNavigationDelegate, ObservableObject {
    var setFilms: ([Film]) -> Void;
    
    init(setFilms: @escaping ([Film]) -> Void) {
        self.setFilms = setFilms;
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("GOOOO");
        let script = """
[...document.querySelectorAll('article.short')].map(i => ({
    title: i.querySelector('a.short_title').textContent,
    preview: i.querySelector('img') && i.querySelector('img').getAttribute('data-src')
}))
""";
        webView.evaluateJavaScript(script) { result, err in
            var allFilms: [Film] = [];
            if let films = result as? [[String: Any]] {
                for rawFilm in films {
                    if let film: Film = try? Film(dictionary: rawFilm) {
                        print(film.title!);
                        allFilms.append(film)
                    }
                }
            }
            
            self.setFilms(allFilms);
        };
    }
}

struct ParseView: UIViewRepresentable {
    let url: String;
    let navigationDelegate: ParseNavigationDelegate;
    
    init(url: String, setFilms: @escaping ([Film]) -> Void) {
        self.url = url;
        self.navigationDelegate = ParseNavigationDelegate(setFilms: setFilms);
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences();
        prefs.allowsContentJavaScript = true;
        let config = WKWebViewConfiguration();
        config.defaultWebpagePreferences = prefs;
        let wv = WKWebView(frame: .zero, configuration: config);
        wv.navigationDelegate = navigationDelegate;
        return wv;
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let myURL = URL(string: url) else {
            return
        }
        let request = URLRequest(url: myURL);
        uiView.load(request);
    }
}

