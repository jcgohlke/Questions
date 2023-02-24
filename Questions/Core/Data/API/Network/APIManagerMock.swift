//
//  APIManagerMock.swift
//  Questions
//
//  Created by Joben Gohlke on 2/20/23.
//

import Foundation

class APIManagerMock: APIManagerProtocol {
  func perform(_ request: RequestProtocol) async throws -> Data {
    let jsonString =
"""
[
  {
    "id":"7D3DEF09-F854-4A29-9918-8EF42227DD24",
    "description":"bar"
  },
  {
    "id":"D24FE8A8-0B9E-4E0F-9516-EBFC85107A11",
    "description":"How do you make a network request receive generic results?"
  },
  {
    "id":"19ABF772-2DD3-4DE5-8D3E-C00D9BFDCECA",
    "description":"Question 3"
  }
]
"""
    
    return jsonString.data(using: .utf8)!
  }
}
