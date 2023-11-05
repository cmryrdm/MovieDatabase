//
//  APICaller.swift
//  MovieDatabase
//
//  Created by CEMRE YARDIM on 27.10.2023.
//

import Foundation

class APICaller {
  
  static let shared = APICaller()
  
  private init() {}
  
  func search(with query: String, completion: @escaping (Result<[Movie], Error>) -> Void ) {
    guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
      return
    }
    
    guard let url = URL(string: "\(Const.baseURL)/3/search/movie?query=\(query)&api_key=\(Const.APIKey)") else {
      return completion(.failure(APIError.wrongUrl))
    }
    
    let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
      guard let data = data, error == nil else {
        return completion(.failure(APIError.failedToFetchData))
      }
      do {
        let results = try JSONDecoder().decode(MovieResponse.self, from: data)
        completion(.success(results.list))
      } catch {
        completion(.failure(APIError.failedToDecodeData))
      }
    }
    task.resume()
  }
  
  func downloadImage(extensionUrl: String?, completion: @escaping (Data?) -> Void) {
    guard let extensionUrl = extensionUrl else {
      return completion(nil)
    }
    
    let fullUrl = "\(Const.posterBaseURL)\(extensionUrl)"
    guard let imageUrl = URL(string: fullUrl) else {
      return completion(nil)
    }
    
    let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
      guard let data = data, error == nil else {
        return completion(nil)
      }
      completion(data)
    }
    task.resume()
  }
}

enum APIError: Error {
  case failedToDecodeData
  case failedToFetchData
  case wrongUrl
}
