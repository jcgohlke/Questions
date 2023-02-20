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
  let marshaler = DataMarshaler()
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
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
    
    let questions: [Question] = try marshaler.marshal(data: data)
    XCTAssertTrue(questions.count == 3, "API should return 3 questions")
  }
  
  func testQuestionFetch() async throws {
    let questionsService = QuestionsService(requestManager: RequestManager())
    let questions = try await questionsService.fetchQuestions()
    XCTAssertTrue(questions.count == 3, "API should return 3 questions")
  }
}
