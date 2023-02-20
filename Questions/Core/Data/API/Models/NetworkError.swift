//
//  NetworkError.swift
//  Questions
//
//  Created by Joben Gohlke on 2/20/23.
//

import Foundation

enum NetworkError: Error {
  case accountNotCreated
  case usernameAlreadyExists
  case loginCredentialEncodingFailed
  case invalidServerResponse
  case unauthenticated
  case serverTimeout503
  case invalidURL
  
  public var errorDescription: String {
    switch self {
      case .accountNotCreated:
        return "Account was not created."
      case .usernameAlreadyExists:
        return "Username already exists."
      case .loginCredentialEncodingFailed:
        return "Could not encode login credentials."
      case .invalidServerResponse:
        return "The server returned an invalid response."
      case .unauthenticated:
        return "User is not authenticated. Please log in."
      case .serverTimeout503:
        return "The server response has timed out with a 503."
      case .invalidURL:
        return "URL string is malformed."
    }
  }
}
