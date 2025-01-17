//
//  Feedback.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 27/12/24.
//

import Foundation

// MARK: - Feedback
enum FeedbackCategory {
    case clarity, tone, pace, fluency
}

struct Feedback {
    var feedbackId: Int
    var recordingId: Int
    var scores: [FeedbackCategory: Int] // Example: [.clarity: 8, .tone: 7]
    var comments: [FeedbackCategory: String]? // Optional comments for each parameter
    var overallComment: String? // Optional summary comment
}

// MARK: - Feedback Data Management
class FeedbackDataModel {

    static let shared = FeedbackDataModel()
    private var feedbacks: [Feedback] = []

    private init() { }

    // Add new feedback
    func addFeedback(_ feedback: Feedback) {
        feedbacks.append(feedback)
    }

    // Fetch feedback by recording ID
    func findFeedbacks(by recordingId: Int) -> [Feedback] {
        return feedbacks.filter { $0.recordingId == recordingId }
    }

    // Fetch feedback by feedback ID
    func getFeedback(by feedbackId: Int) -> Feedback? {
        return feedbacks.first { $0.feedbackId == feedbackId }
    }
}

