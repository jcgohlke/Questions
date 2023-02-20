//
//  RequestProtocol.swift
//  Questions
//
//  Created by Joben Gohlke on 2/20/23.
//

import Foundation

protocol RequestProtocol {
  var host: String { get }
  var path: String? { get }
  var httpMethod: HTTPMethod { get }
  var headers: [String: String] { get }
  var body: Data? { get }
  var urlParams: [String: String?] { get }
  var isJson: Bool { get }
}

// MARK: - Default RequestProtocol
extension RequestProtocol {
  var isJson: Bool {
    true
  }

  var urlParams: [String: String?] {
    [:]
  }

  var headers: [String: String] {
    [:]
  }
  
  var body: Data? {
    nil
  }

  func createURLRequest() throws -> URLRequest {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    if let path {
      components.path = path
    }

    if !urlParams.isEmpty {
      components.queryItems = urlParams.map { URLQueryItem(name: $0, value: $1) }
    }

    guard let url = components.url else { throw  NetworkError.invalidURL }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = httpMethod.description

    if !headers.isEmpty {
      urlRequest.allHTTPHeaderFields = headers
    }

    if isJson {
      urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }

    if let body = body {
      urlRequest.httpBody = body
    }

    return urlRequest
  }
}

