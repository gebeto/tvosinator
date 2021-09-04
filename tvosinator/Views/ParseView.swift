//
//  ParseView.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import Foundation
import SwiftUI
import WebKit


class ParseNavigationDelegate: NSObject, WKNavigationDelegate, ObservableObject {
    var setFilmsSections: ([FilmsSection]) -> Void;
    
    init(setFilmsSections: @escaping ([FilmsSection]) -> Void) {
        self.setFilmsSections = setFilmsSections;
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("GOOOO");
        let script = """
const sections = [...document.querySelectorAll('section.section')];
sections.map(section => ({
title: section.querySelector('a').textContent,
films: [...section.querySelectorAll('article.short')].map(i => ({
    link: i.querySelector('a.short_title').href,
    title: i.querySelector('a.short_title').textContent,
    preview: i.querySelector('img') && 'http://eneyida.tv' + i.querySelector('img').getAttribute('data-src')
}))
})).filter(i => i.films.length)
""";
        webView.evaluateJavaScript(script) { result, err in
            var allFilmsSections: [FilmsSection] = [];
            if let sections = result as? [[String: Any]] {
                for rawSection in sections {
                    if let section: FilmsSection = try? FilmsSection(dictionary: rawSection) {
                        print(section.title!);
                        allFilmsSections.append(section)
                    }
                }
            }
            self.setFilmsSections(allFilmsSections);
        };
    }
}

struct SimpleWebView: UIViewRepresentable {
    var url: String;
    
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences();
        prefs.allowsContentJavaScript = true;
        let config = WKWebViewConfiguration();
        config.defaultWebpagePreferences = prefs;
        return WKWebView(frame: .zero, configuration: config);
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let myURL = URL(string: url) else {
            return
        }
        let request = URLRequest(url: myURL);
        uiView.load(request);
    }
}

struct ParseView: UIViewRepresentable {
    let url: String;
    let navigationDelegate: ParseNavigationDelegate;
    
    init(url: String, setFilmsSections: @escaping ([FilmsSection]) -> Void) {
        self.url = url;
        self.navigationDelegate = ParseNavigationDelegate(setFilmsSections: setFilmsSections);
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

