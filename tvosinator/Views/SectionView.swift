//
//  SectionView.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import SwiftUI
import URLImage


struct SectionView: View {
    var filmsSection: FilmsSection;
    var highlighted: Bool;
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(filmsSection.title)
                .font(.title.weight(.bold))
                .padding(.leading, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(filmsSection.films, id: \.title) { film in
                        FilmView(film: film)
                    }
                }
                .padding()
            }
        }
        .padding(.top, 30)
        .background(Color.primary.opacity(highlighted ? 0.04 : 0))
    }
}


struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(
            filmsSection: FilmsSection(
                title: "Hello world",
                films: [
                    Film(title: "Film 1", preview: "preview", link: "http://google.com"),
                    Film(title: "Film 2", preview: "preview", link: "http://google.com"),
                    Film(title: "Film 3", preview: "preview", link: "http://google.com")
                ]
            ),
            highlighted: true
        )
    }
}
