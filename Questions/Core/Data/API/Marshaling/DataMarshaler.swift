//
//  DataMarshaler.swift
//  Questions
//
//  Created by Joben Gohlke on 2/20/23.
//

import Foundation

protocol DataMarshalerProtocol {
  func marshal<T: Decodable>(data: Data) throws -> T
}

class DataMarshaler: DataMarshalerProtocol {
  private var jsonDecoder: JSONDecoder

  init(jsonDecoder: JSONDecoder = JSONDecoder()) {
    jsonDecoder.dateDecodingStrategy = .iso8601
    self.jsonDecoder = jsonDecoder
  }

  func marshal<T: Decodable>(data: Data) throws -> T {
    return try jsonDecoder.decode(T.self, from: data)
  }
}
