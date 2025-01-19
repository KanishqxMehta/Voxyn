//
//  Feedback.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 27/12/24.
//

import Foundation

// MARK: - Feedback
enum FeedbackCategory: String {
    case clarity = "clarity"
    case tone = "tone"
    case pace = "pace"
    case fluency = "fluency"

    var displayName: String {
        switch self {
        case .clarity:
            return "Clarity"
        case .tone:
            return "Tone"
        case .pace:
            return "Pace"
        case .fluency:
            return "Fluency"
        }
    }
}

struct Feedback {
    let feedbackId: Int
    let recordingId: Int
    var scores: [FeedbackCategory: Int]
    var comments: [FeedbackCategory: String]?
    var overallComment: String?
    
    init(feedbackId: Int, recordingId: Int, scores: [FeedbackCategory: Int], comments: [FeedbackCategory: String]? = nil, overallComment: String? = nil) {
        self.feedbackId = feedbackId
        self.recordingId = recordingId
        self.scores = scores
        self.comments = comments
        self.overallComment = overallComment
    }
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

