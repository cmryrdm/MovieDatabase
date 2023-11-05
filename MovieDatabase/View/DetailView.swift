//
//  DetailView.swift
//  MovieDatabase
//
//  Created by CEMRE YARDIM on 29.10.2023.
//

import SwiftUI

struct DetailView: View {
  let movie: MappedMovie
  
  init(_ movie: MappedMovie) {
    self.movie = movie
  }
  
  var body: some View {
    
    ScrollView {
      VStack {
        
        PosterView(posterPath: movie.poster)
          .aspectRatio(contentMode: .fit)
          .frame(width: UIScreen.main.bounds.width * 0.9)
          .overlay(content: {
            Rectangle()
              .stroke(.white, lineWidth: 4)
              .shadow(radius: 4)
          })
        
        Text(movie.overview)
          .multilineTextAlignment(.center)
          .padding(.horizontal)
        
        
      }
      
      
    }.navigationTitle(movie.title)
  }
}

//#Preview {
//  DetailView()
//}
