//
//  FetchQuestionsRequest.swift
//  Questions
//
//  Created by Joben Gohlke on 2/20/23.
//

import Foundation

enum FetchQuestionsRequest: RequestProtocol {
  case fetchQuestions
  
  var host: String {
    APIConstants.questionsHost
  }
  
  var path: String? {
     "/api/nvonotyj01o"
  }
  
  var httpMethod: HTTPMethod {
    .get
  }
}
