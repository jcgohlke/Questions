//
//  QuestionsService.swift
//  Questions
//
//  Created by Joben Gohlke on 2/20/23.
//

import Foundation
import OSLog

protocol QuestionsFetcher {
  func fetchQuestions() async throws -> [Question]
}

actor QuestionsService {
  private let requestManager: RequestManagerProtocol
  let logger = Logger(subsystem: "org.UnderdogDevs.Questions", category: "QuestionsService")
  
  init(requestManager: RequestManagerProtocol) {
    self.requestManager = requestManager
  }
}

extension QuestionsService: QuestionsFetcher {
  func fetchQuestions() async throws -> [Question] {
    let fetchQuestionsRequest: FetchQuestionsRequest = .fetchQuestions
    
    let questions: [Question] = try await requestManager.perform(fetchQuestionsRequest)
    logger.debug("\(questions.count) questions received.")
    return questions
  }
}
