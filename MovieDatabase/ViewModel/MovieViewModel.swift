//
//  MovieViewModel.swift
//  MovieDatabase
//
//  Created by CEMRE YARDIM on 27.10.2023.
//

import SwiftUI

class MovieViewModel: ObservableObject {
  
  @Published var movies = [MappedMovie]()
  @Published var image : Data?
  
  func searchMovie(title: String) {
    APICaller.shared.search(with: title) { result in
      switch result {
      case .failure(let error):
        print(error)
      case .success(let list):
        
        DispatchQueue.main.async {
          self.movies = list.map(MappedMovie.init)
        }
      }
    }
  }
  
  func fetchImage(extensionUrl: String?) {
    APICaller.shared.downloadImage(extensionUrl: extensionUrl) { data in
      if let data = data {
        DispatchQueue.main.async {
          self.image = data
        }
      }
    }
  }
}

struct MappedMovie: Identifiable {
  let movie: Movie
  
  var id: Int {
    movie.id
  }
  
  var title: String {
    movie.original_title ?? ""
  }
  
  var poster: String {
    movie.poster_path ?? ""
  }
  
  var overview: String {
    movie.overview ?? ""
  }
  
  var date: String {
    movie.release_date ?? ""
  }
}
