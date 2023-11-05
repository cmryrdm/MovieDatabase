//
//  ContentView.swift
//  MovieDatabase
//
//  Created by CEMRE YARDIM on 27.10.2023.
//

import SwiftUI

struct MovieListView: View {
  @ObservedObject var movieViewModel = MovieViewModel()
  @State private var searchText = ""
  @State private var showList = false
  
  var body: some View {
    
    NavigationStack {
      VStack {
        HStack {
          
          TextField("Search", text: $searchText)
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding(.leading)
            .font(.title)
          
          Button("Go") {
            movieViewModel.searchMovie(title: searchText)
            showList = true
          }.buttonStyle(.bordered)
            .foregroundStyle(.black)
            .font(.title)
            .padding(.trailing)
        }
        
        if showList {
          List {
            ForEach(movieViewModel.movies) { movie in
              NavigationLink {
                DetailView(movie)
              } label: {
                HStack {
                  PosterView(posterPath: movie.poster)
                    .frame(width:80, height: 80)
                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                    .aspectRatio(contentMode: .fit)
                  VStack {
                    Text(movie.title)
                    Text(movie.date)
                  }
                }
              }
            }.listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
              .listRowSeparator(.automatic)
          }.listStyle(.plain)
            .listRowSpacing(0)
        }
        
        Spacer()
        
      }.navigationTitle("Movie Database")
    }.tint(.black)
  }
}

//#Preview {
//  MovieListView()
//}
