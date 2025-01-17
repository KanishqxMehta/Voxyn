//
//  Recording.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 27/12/24.
//

import Foundation

// MARK: - Recording
struct Recording {
    let recordingId: Int
    let userId: Int
    var title: String
    var audioFileURL: String
    var timestamp: Date
    var sessionType: SessionType
    var feedback: Feedback // Link to Feedback by ID
    var analytics: RecordingAnalytics  // New: Detailed analytics
    
    // New: Computed property for overall score
    var overallScore: Double {
        let scores = feedback.scores
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


// MARK: - Recording Analytics
struct RecordingAnalytics {
    let duration: TimeInterval
    let wordsPerMinute: Double?
    let silenceDuration: TimeInterval
    let volumeVariation: Double
    let pronunciationAccuracy: Double
    var transcription: String?    // New: Store speech-to-text
    var keyPhrases: [String]     // New: Important phrases detected
    var improvementSuggestions: [String] // New: AI-generated suggestions
}


// MARK: - Recording Data Management
class RecordingDataModel {
    static let shared = RecordingDataModel()
    private var recordings: [Recording] = []

    private init() { }
    
    // Add a new recording
    func saveRecording(_ recording: Recording) {
        recordings.append(recording)
    }
    
    // Fetch all recordings by user ID
    func findRecordings(by userId: Int) -> [Recording] {
        return recordings.filter { $0.userId == userId }
    }
    
    func getRecording(by recordingId: Int) -> Recording? {
        return recordings.first { $0.recordingId == recordingId }
    }
    
    // Search recordings by title
    func searchRecordings(by title: String) -> [Recording] {
        return recordings.filter { $0.title.lowercased().contains(title.lowercased()) }
    }
    
    // Delete a recording by ID
    func deleteRecording(by id: Int) -> Bool {
        if let index = recordings.firstIndex(where: { $0.recordingId == id }) {
            recordings.remove(at: index)
            return true
        }
        return false
    }
}
