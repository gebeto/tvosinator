//
//  FilmPageView.swift
//  tvosinator
//
//  Created by gebeto on 24.11.2021.
//

import SwiftUI

struct FilmPageView: View {
    var url: String;
    @StateObject var parser = FilmParser();
    
    var body: some View {
        ScrollView {
            Text(url)
                .onAppear {
                    parser.parse(url: url)
                }
            if parser.film != nil {
                Text(parser.film!.m3u8!)
            }
        }
    }
}
