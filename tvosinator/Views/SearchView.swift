//
//  SearchView.swift
//  tvosinator
//
//  Created by gebeto on 05.09.2021.
//

import SwiftUI


let seatchParseScript = """
({
    data: [...document.querySelectorAll('article.short')].map(i => ({
        link: i.querySelector('a.short_title').href,
        title: i.querySelector('a.short_title').textContent,
        preview: i.querySelector('img') && 'http://eneyida.tv' + i.querySelector('img').getAttribute('data-src'),
        year: i.querySelector('.short_subtitle').textContent.split(' • ')[0],
        original: i.querySelector('.short_subtitle').textContent.split(' • ')[1],
    }))
})
""";


struct SearchView: View {
    @State var films: [Film] = [];
    @State var inputSearchQuery = "test";
    
    @State var parser = SimpleParser()
    
    func search() {
        parser.parse(query: self.inputSearchQuery);
    }
    
    var body: some View {
        SearchNavigationView(text: $inputSearchQuery, search: self.search, cancel: {}) {
            ScrollView {
                ForEach(self.films, id: \.title) { film in
                    FilmViewHorizontal(film: film)
                }
                .padding(.top, 4)
                .padding(.horizontal, 10)
            }
            .navigationTitle("Search")
        }.edgesIgnoringSafeArea(.top)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
