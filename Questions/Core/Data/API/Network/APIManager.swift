//
//  APIManager.swift
//  Questions
//
//  Created by Joben Gohlke on 2/20/23.
//

import Foundation
import OSLog

protocol APIManagerProtocol {
  func perform(_ request: RequestProtocol) async throws -> Data
}

class APIManager: APIManagerProtocol {
  private let urlSession: URLSession
  
  let logger = Logger(subsystem: "org.UnderdogDevs.Questions", category: "APIManager")

  init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }

  func perform(_ request: RequestProtocol) async throws -> Data {
    let (data, response) = try await urlSession.data(for: request.createURLRequest())
    guard let httpResponse = response as? HTTPURLResponse else {
      throw NetworkError.invalidServerResponse
    }
    
    switch httpResponse.statusCode {
      case 200:
        return data
      default:
        logger.error("Status code not found: \(httpResponse.statusCode)")
        throw NetworkError.invalidServerResponse
    }
  }
}
