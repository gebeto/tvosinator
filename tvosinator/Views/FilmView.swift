//
//  FilmView.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import SwiftUI
import URLImage
import WebKit


struct FilmView: View {
    var film: Film;
    @State var isPageOpen = false;
    
    var body: some View {
        VStack {
            if film.preview.starts(with: "http") {
                URLImage(URL(string: film.preview)!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 250, alignment: .center)
                        .cornerRadius(6)
                }
            } else {
                Image(film.preview)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 250, alignment: .center)
                    .cornerRadius(6)
            }
            Text(film.title)
                .font(.caption)
                .lineLimit(1)
                .frame(width: 150)
                .frame(height: 24, alignment: .center)
        }
        .padding(10)
        .frame(height: 300)
        .cornerRadius(12)
        .onTapGesture {
            isPageOpen = true;
        }
        .sheet(isPresented: $isPageOpen, content: {
            FilmWebView(url: film.link)
                .ignoresSafeArea()
        })
    }
}

struct FilmView_Previews: PreviewProvider {
    static var previews: some View {
        FilmView(film: Film(title: "Hello world", preview: "preview.jpg", link: "https://google.com"))
            .previewLayout(.sizeThatFits)
    }
}
