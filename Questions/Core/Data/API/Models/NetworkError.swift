//
//  NetworkError.swift
//  Questions
//
//  Created by Joben Gohlke on 2/20/23.
//

import Foundation

enum NetworkError: Error {
  case invalidServerResponse
  case invalidURL
  
  public var errorDescription: String {
    switch self {
      case .invalidServerResponse:
        return "The server returned an invalid response."
      case .invalidURL:
        return "URL string is malformed."
    }
  }
}
