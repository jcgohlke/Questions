//
//  ContentView.swift
//  Questions
//
//  Created by Joben Gohlke on 2/20/23.
//

import SwiftUI
import OSLog

struct ContentView: View {
  @State private var questions: [Question] = []
  let logger = Logger(subsystem: "org.UnderdogDevs.Questions", category: "ContentView")
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(questions) { question in
          HStack {
            Text(question.description)
            
            Spacer()
            
            Button(action: {}) {
              VStack {
                Image(systemName: "arrow.up")
                Text("25")
                  .font(.caption)
                  .foregroundColor(.primary)
              }
            }
          }
        }
      }
      .navigationTitle("Questions")
    }
    .task {
      await fetchQuestions()
    }
  }
  
  private func fetchQuestions() async {
    let questionsService = QuestionsService(requestManager: RequestManager())
    do {
      questions = try await questionsService.fetchQuestions()
    } catch {
      logger.error("Error getting questions: \(error.localizedDescription)")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
