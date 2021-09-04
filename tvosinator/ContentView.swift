//
//  ContentView.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import SwiftUI
import URLImage


let seatchParseScript = """
({
    data: [...document.querySelectorAll('article.short')].map(i => ({
        link: i.querySelector('a.short_title').href,
        title: i.querySelector('a.short_title').textContent,
        preview: i.querySelector('img') && 'http://eneyida.tv' + i.querySelector('img').getAttribute('data-src')
    }))
})
""";


struct ContentView: View {
    @State var films: [Film] = [];
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            VStack {
                Text("Hello")
                SearchParseView(
                    url: "https://eneyida.tv/index.php?story=test&do=search&subaction=search",
                    script: seatchParseScript,
                    setFilms: { films in
                        self.films = films;
                    }
                ).frame(height: 0)
                ScrollView() {
                    VStack {
                        ForEach(self.films, id: \.title) { film in
                            FilmView(film: film)
                        }
                    }
                }
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }
    }
}
