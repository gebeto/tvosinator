//
//  FilmView.swift
//  tvosinator
//
//  Created by gebeto on 04.09.2021.
//

import SwiftUI
import URLImage
import WebKit


struct FilmViewHorizontal: View {
    var film: FilmItem;
    @State var isPageOpen = false;
    
    var body: some View {
        HStack(alignment: .top) {
            if film.preview.starts(with: "http") {
                URLImage(URL(string: film.preview)!) {
                    ProgressView()
                        .frame(width: 66, height: 100, alignment: .center)
                } inProgress: { progress in
                    ProgressView()
                        .frame(width: 66, height: 100, alignment: .center)
                } failure: { err, fail in
                    Text("Fail")
                } content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100, alignment: .center)
                        .cornerRadius(6)
                }

            } else {
                Image(film.preview)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100, alignment: .center)
                    .cornerRadius(6)
            }
            VStack(alignment: .leading) {
                Text(film.title)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(3)
                if film.original != nil {
                    Text(film.original!)
                        .font(.caption)
                        .lineLimit(3)
                }
                Spacer()
                if film.year != nil {
                    HStack {
                        Spacer()
                        Text(film.year!)
                            .font(.title)
                            .foregroundColor(.blue.opacity(0.2))
                    }
                }
            }
            .padding(.leading, 6)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color.primary.opacity(0.02))
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
//
//struct FilmView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack(alignment: .leading) {
//            FilmViewHorizontal(film: FilmItem(title: "Hello world", preview: "preview.jpg", link: "https://google.com"))
//        }
//        .frame(width: 300, height: 300)
//        .previewLayout(.sizeThatFits)
//    }
//}
