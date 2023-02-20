//
//  StandardResponse.swift
//  Questions
//
//  Created by Joben Gohlke on 2/20/23.
//

import Foundation

struct StandardResponse: Decodable {
  let success: Bool
  let statusCode: Int
}
