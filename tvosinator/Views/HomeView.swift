//
//  HomeView.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import SwiftUI

struct HomeView: View {
    @State var filmsSections: [FilmsSection] = [];
    
    var body: some View {
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
            }.padding(.top, 24)
        }
    }
}
