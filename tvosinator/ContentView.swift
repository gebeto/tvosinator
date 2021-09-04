//
//  ContentView.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import SwiftUI
import URLImage


struct ContentView: View {
    @State var filmsSections: [FilmsSection] = [];
    
    var body: some View {
        NavigationView {
            ScrollView {
                ParseView(url: "http://eneyida.tv", setFilmsSections: { filmsSections in
                    self.filmsSections = filmsSections;
                }).frame(height: 0)
                VStack(spacing: 0) {
                    ForEach(Array(filmsSections.enumerated()), id: \.offset) { index, filmsSection in
                        VStack {
                            SectionView(filmsSection: filmsSection, highlighted: index % 2 != 0)
                        }
                    }
                }.padding(.top, 48)
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
