//
//  RequestManager.swift
//  Questions
//
//  Created by Joben Gohlke on 2/20/23.
//

import Foundation

protocol RequestManagerProtocol {
  func perform(_ request: RequestProtocol) async throws
  func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

class RequestManager: RequestManagerProtocol {
  let apiManager: APIManagerProtocol
  let marshaler: DataMarshalerProtocol

  init(
    apiManager: APIManagerProtocol = APIManager(),
    marshaler: DataMarshalerProtocol = DataMarshaler()
   ) {
    self.apiManager = apiManager
    self.marshaler = marshaler
  }

  func perform(_ request: RequestProtocol) async throws {
    let _ = try await apiManager.perform(request)
  }
  
  func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T {
    let data = try await apiManager.perform(request)
    let decoded: T = try marshaler.marshal(data: data)
    return decoded
  }
}
