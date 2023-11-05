//
//  PosterView.swift
//  MovieDatabase
//
//  Created by CEMRE YARDIM on 29.10.2023.
//

import SwiftUI

struct PosterView: View {
  let posterPath : String
  @ObservedObject var movieViewModel = MovieViewModel()
  
  init(posterPath: String) {
    self.posterPath = posterPath
    self.movieViewModel.fetchImage(extensionUrl: self.posterPath)
  }
  
  var body: some View {
    if let data = movieViewModel.image {
      return Image(uiImage: ((UIImage(data: data) ?? UIImage(named: "placeholder"))!))
        .resizable()
    } else {
      return Image("placeholder")
        .resizable()
    }
  }
}

//#Preview {
//  PosterView()
//}
