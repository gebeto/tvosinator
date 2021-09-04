//
//  FilmWebView.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import SwiftUI
import WebKit


class FilmWebViewDelegate: NSObject, WKNavigationDelegate {
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.evaluateJavaScript("""
//const iframe = document.querySelector('iframe').src;
//document.body.innerHTML = '<iframe src="' + iframe + '" /><style type="text/css">iframe{ width: 100vw; }</style>';
//""")
//    }
}

struct FilmWebView: UIViewRepresentable {
    let url: String;
    private let navigationDelegate = FilmWebViewDelegate();
    
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

