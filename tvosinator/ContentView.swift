//
//  ContentView.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import SwiftUI
import URLImage
import AVKit


struct ContentView: View {
    var body: some View {
        TabView {
//            HomeView()
//                .tabItem {
//                    Image(systemName: "house.fill")
//                    Text("Home")
//                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            FilmFileView(url: "https://jordkym.cyou/new4/moana_2016_bdrip_1080p_h.265_ukr_eng_hurtom_6358/hls/index.m3u8")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
    }
}
