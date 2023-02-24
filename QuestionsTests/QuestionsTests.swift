//
//  QuestionsTests.swift
//  QuestionsTests
//
//  Created by Joben Gohlke on 2/20/23.
//

import XCTest
@testable import Questions

final class QuestionsTests: XCTestCase {
  let urlSession = URLSession.shared
  
  func testQuestionRequest() async throws {
    let fetchQuestionsRequest = FetchQuestionsRequest.fetchQuestions
    let urlRequest = try fetchQuestionsRequest.createURLRequest()
    if let url = urlRequest.url {
      XCTAssertTrue(url.absoluteString == "https://simplejsoncms.com/api/nvonotyj01o", "URL not in correct format")
    }
    let (data, response) = try await urlSession.data(for: urlRequest)

    guard let httpResponse = response as? HTTPURLResponse else {
      XCTFail("Response could not be cast to an HTTPURLResponse.")
      throw NetworkError.invalidServerResponse
    }

    XCTAssertTrue(httpResponse.statusCode == 200, "Reponse did not return 200: code=\(httpResponse.statusCode)")
    
    let questions: [Question] = try JSONDecoder().decode([Question].self, from: data)
    XCTAssertTrue(questions.count == 3, "API should return 3 questions")
  }
  
  func testAPIManagerMocked() async throws {
    let fetchQuestionsRequest = FetchQuestionsRequest.fetchQuestions
    
    let apiManager = APIManagerMock()
    let data = try await apiManager.perform(fetchQuestionsRequest)
    
    let questions: [Question] = try DataMarshaler().marshal(data: data)
    XCTAssertTrue(questions.count == 3, "API should return 3 questions")
  }
  
  func testAPIManager() async throws {
    let fetchQuestionsRequest = FetchQuestionsRequest.fetchQuestions
    
    let apiManager = APIManager(urlSession: urlSession)
    let data = try await apiManager.perform(fetchQuestionsRequest)
    
    let questions: [Question] = try DataMarshaler().marshal(data: data)
    XCTAssertTrue(questions.count == 3, "API should return 3 questions")
  }
  
  func testRequestManager() async throws {
    let fetchQuestionsRequest = FetchQuestionsRequest.fetchQuestions
    
    let requestManager = RequestManager()
    let questions: [Question] = try await requestManager.perform(fetchQuestionsRequest)
    
    XCTAssertTrue(questions.count == 3, "API should return 3 questions")
  }
  
  func testQuestionFetch() async throws {
    let questionsService = QuestionsService(requestManager: RequestManager())
    let questions = try await questionsService.fetchQuestions()
    XCTAssertTrue(questions.count == 3, "API should return 3 questions")
  }
}
