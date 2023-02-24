//
//  Question.swift
//  Questions
//
//  Created by Joben Gohlke on 2/20/23.
//

import Foundation

struct Question: Decodable, Identifiable {
  let id: String
  let description: String
}
