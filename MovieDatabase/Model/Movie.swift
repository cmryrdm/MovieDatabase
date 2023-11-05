//
//  Movie.swift
//  MovieDatabase
//
//  Created by CEMRE YARDIM on 27.10.2023.
//

import Foundation

struct MovieResponse: Codable {
  let list: [Movie]
  
  private enum CodingKeys: String, CodingKey {
    case list = "results"
  }
}

struct Movie: Codable, Identifiable { // baseURL = "https://api.themoviedb.org"
  let id: Int
  let original_title: String?
  let overview: String?
  let poster_path: String? // posterBaseURL = "http://image.tmdb.org/t/p/w500/poster_path"
  let release_date: String?
  let vote_average: Double
  let vote_count: Int
}
