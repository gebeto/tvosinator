//
//  SearchView.swift
//  tvosinator
//
//  Created by gebeto on 05.09.2021.
//

import SwiftUI


struct SearchView: View {
    @State var films: [Film] = [];
    @State var inputSearchQuery = "";
    
    @StateObject var parser = SimpleParser()
    
    func search() {
        parser.parse(query: self.inputSearchQuery);
    }
    
    var body: some View {
        SearchNavigationView(text: $inputSearchQuery, search: self.search, cancel: {}) {
            ScrollView {
                if parser.loading {
                    Text("Loading...")
                } else {
                    ForEach(self.parser.items, id: \.title) { film in
                        FilmViewHorizontal(film: film)
                    }
                    .padding(.top, 4)
                    .padding(.horizontal, 10)
                }
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
