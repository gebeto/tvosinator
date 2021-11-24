//
//  FilmPageView.swift
//  tvosinator
//
//  Created by gebeto on 24.11.2021.
//

import SwiftUI
import AVKit


struct FilmFileView: View {
    var url: String;
    
    var body: some View {
        ScrollView {
            VideoPlayer(player: AVPlayer(url: URL(string: url)!))
            .frame(minHeight: 300)
        }
    }
}



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
                FilmFileView(url: parser.film!.m3u8!)
            }
        }
    }
}
