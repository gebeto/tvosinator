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
    var script: String;
    var setResult: (Any?) -> Void;
    
    init(script: String, setResult: @escaping (Any?) -> Void) {
        self.script = script;
        self.setResult = setResult;
    }
    
    func dictToObject(dict: [String: Any]) {
        print("Please override this");
//        if let formattedData = try? FilmsSection(dictionary: dict) {
//            self.setResult(formattedData);
//        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript(script) { result, err in
            if let dict = result as? [String: Any] {
                self.dictToObject(dict: dict)
            }
        };
    }
}

protocol ParseView: UIViewRepresentable {
    var navigationDelegate: ParseNavigationDelegate { get set };
    var url: String { get set };
}

extension ParseView {
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences();
        prefs.allowsContentJavaScript = true;
        let config = WKWebViewConfiguration();
        config.defaultWebpagePreferences = prefs;
        let wv = WKWebView(frame: .zero, configuration: config);
        wv.navigationDelegate = navigationDelegate;
        return wv;
    }
    
    func createURLRequest(url: URL) -> URLRequest {
        let request = URLRequest(url: url);
        return request;
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let myURL = URL(string: url) else {
            return
        }
        let request = createURLRequest(url: myURL);
        uiView.load(request);
    }
}

