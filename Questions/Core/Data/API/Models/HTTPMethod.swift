//
//  HTTPMethod.swift
//  Questions
//
//  Created by Joben Gohlke on 2/20/23.
//

import Foundation

enum HTTPMethod: String, CustomStringConvertible {
  var description: String {
    self.rawValue
  }
  
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}
