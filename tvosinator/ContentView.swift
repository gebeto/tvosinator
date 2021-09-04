//
//  ContentView.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import SwiftUI
import URLImage


struct FilmsScrollView: View {
    var films: [Film];
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(films, id: \.title) { film in
                        VStack {
                            URLImage(URL(string: "http://eneyida.tv\(film.preview!)")!) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 250, alignment: .center)
                                    .cornerRadius(6)
                            }
                            Text(film.title!)
                                .font(.caption)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .frame(width: 150)
                        }
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.white)
                        .cornerRadius(12)
                        .contextMenu(ContextMenu(menuItems: {
                            Text("Menu Item 1")
                            Text("Menu Item 2")
                            Text("Menu Item 3")
                        }))
                    }
                }
                .padding()
            }
        }
    }
}


struct ContentView: View {
    @State var films: [Film] = [];
    
    var body: some View {
        NavigationView {
            ScrollView {
                ParseView(url: "http://eneyida.tv", setFilms: { films in
                    self.films = films;
                }).frame(height: 0)
                FilmsScrollView(films: films)
                FilmsScrollView(films: films)
                FilmsScrollView(films: films)
                FilmsScrollView(films: films)
            }
            .navigationTitle("Films")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
