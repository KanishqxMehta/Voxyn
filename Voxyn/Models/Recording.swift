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
    var topicId: Int
 //   var feedback: Feedback // Link to Feedback by ID
  //  var analytics: RecordingAnalytics  // New: Detailed analytics
    
    // New: Computed property for overall score
   
}


// MARK: - Recording Analytics
//struct RecordingAnalytics {
//    let duration: TimeInterval
//    let wordsPerMinute: Double?
//    let silenceDuration: TimeInterval
//    let volumeVariation: Double
//    let pronunciationAccuracy: Double
//    var transcription: String?    // New: Store speech-to-text
//    var keyPhrases: [String]     // New: Important phrases detected
//    var improvementSuggestions: [String] // New: AI-generated suggestions
//}


// MARK: - Recording Data Management
// MARK: - Recording Data Management
class RecordingDataModel {
    static let shared = RecordingDataModel()
    private var recordings: [Recording] = []

    private init() {
        // Static test data for recordings
        let calendar = Calendar.current
        let today = Date()
        
        // Get the start of the current week (Monday)
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        let monday = startOfWeek
        let tuesday = calendar.date(byAdding: .day, value: 1, to: monday)!
        let wednesday = calendar.date(byAdding: .day, value: 2, to: monday)!

        recordings = [
        ]
    }
    
    // get all the recordings
    func getAllRecordings() -> [Recording] {
        return recordings
    }
    
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
    
    func calculateAverageScores(for recordings: [Recording]) -> [FeedbackCategory: Double] {
        var totalScores: [FeedbackCategory: Int] = [
            .clarity: 0,
            .tone: 0,
            .pace: 0,
            .fluency: 0
        ]
        
        var recordingCount = 0
        
        for recording in recordings {
            // Find feedbacks for the specific recording
            let feedbacks = FeedbackDataModel.shared.findFeedbacks(by: recording.recordingId)
            
            // If feedback exists for the recording
            if let feedback = feedbacks.first {
                for (category, score) in feedback.scores {
                    totalScores[category, default: 0] += score
                }
                recordingCount += 1
            }
        }
        
        // If no recordings have feedback, return zero scores
        guard recordingCount > 0 else {
            return [.clarity: 0, .tone: 0, .pace: 0, .fluency: 0]
        }
        
        // Calculate average scores
        return totalScores.mapValues { Double($0) / Double(recordingCount) }
    }
}
