//
//  SimpleWebView.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import SwiftUI
import WebKit


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
