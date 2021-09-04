//
//  HomeView.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import SwiftUI


let parseScript = """
    ({
        data: [...document.querySelectorAll('section.section')].map(section => ({
            title: section.querySelector('a').textContent,
            films: [...section.querySelectorAll('article.short')].map(i => ({
                link: i.querySelector('a.short_title').href,
                title: i.querySelector('a.short_title').textContent,
                preview: i.querySelector('img') && 'http://eneyida.tv' + i.querySelector('img').getAttribute('data-src')
            }))
        })).filter(i => i.films.length)
    })
"""


struct HomeView: View {
    @State var filmsSections: [FilmsSection] = [];
    
    var body: some View {
        ScrollView {
            HomeParseView(url: "http://eneyida.tv", script: parseScript, setFilmsSections: { filmsSections in
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
