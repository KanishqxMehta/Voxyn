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
    
    var overallScore: Double {
        let scores = scores
        let weights: [FeedbackCategory: Double] = [
            .clarity: 0.3,
            .tone: 0.25,
            .pace: 0.25,
            .fluency: 0.2
        ]
        
        var weightedSum = 0.0
        for (category, score) in scores {
            weightedSum += Double(score) * (weights[category] ?? 0)
        }
        return weightedSum
    }
}

// MARK: - Feedback Data Management
import Foundation

class FeedbackDataModel {
    static let shared = FeedbackDataModel()
    private var feedbacks: [Feedback] = []

    private init() {
        // Initialize with empty feedback array
        feedbacks = []
        print("FeedbackDataModel initialized with empty feedback array")
    }

    func getAllFeedbacks() -> [Feedback] {
        return feedbacks
    }
    
    // Add new feedback
    func addFeedback(_ feedback: Feedback) {
        print("Adding Feedback - Recording ID: \(feedback.recordingId)")
        print("Feedback Scores: \(feedback.scores)")
        feedbacks.append(feedback)
    }

    // Fetch feedback by recording ID
    func findFeedbacks(by recordingId: Int) -> [Feedback] {
        let matchedFeedbacks = feedbacks.filter { $0.recordingId == recordingId }
        print("Finding Feedbacks for Recording ID: \(recordingId)")
        print("Matched Feedbacks Count: \(matchedFeedbacks.count)")
        return matchedFeedbacks
    }
    
    func findFeedbacks(by recordingIds: [Int]) -> [Feedback] {
        let matchedFeedbacks = feedbacks.filter { recordingIds.contains($0.recordingId) }
        print("Finding Feedbacks for Recording IDs: \(recordingIds)")
        print("Matched Feedbacks Count: \(matchedFeedbacks.count)")
        return matchedFeedbacks
    }

    // Fetch feedback by feedback ID
    func getFeedback(by feedbackId: Int) -> Feedback? {
        return feedbacks.first { $0.feedbackId == feedbackId }
    }

    // Debug method to print all current feedbacks
    func printAllFeedbacks() {
        print("Total Feedbacks: \(feedbacks.count)")
        for feedback in feedbacks {
            print("Feedback ID: \(feedback.feedbackId), Recording ID: \(feedback.recordingId)")
            print("Scores: \(feedback.scores)")
        }
    }
}
