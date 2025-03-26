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
//            Recording(
//                recordingId: 1,
//                userId: 1,
//                title: "Read Aloud 1",
//                audioFileURL: "",
//                timestamp: monday, // Monday
//                sessionType: .readAloud,
//                feedback: Feedback(
//                    feedbackId: 1,
//                    recordingId: 1,
//                    scores: [.clarity: 85, .tone: 90, .pace: 80, .fluency: 75],
//                    comments: [.clarity: "Good clarity", .tone: "Great tone"],
//                    overallComment: "Excellent progress"
//                ),
//                analytics: RecordingAnalytics(
//                    duration: 120,
//                    wordsPerMinute: 110,
//                    silenceDuration: 10,
//                    volumeVariation: 0.8,
//                    pronunciationAccuracy: 95,
//                    transcription: "This is a sample transcription.",
//                    keyPhrases: ["Current Affairs", "Important topics"],
//                    improvementSuggestions: ["Work on pacing", "Reduce pauses"]
//                )
//            ),
//            Recording(
//                recordingId: 2,
//                userId: 1,
//                title: "Random Prompt 1",
//                audioFileURL: "",
//                timestamp: tuesday, // Tuesday
//                sessionType: .randomTopic,
//                feedback: Feedback(
//                    feedbackId: 2,
//                    recordingId: 2,
//                    scores: [.clarity: 70, .tone: 75, .pace: 85, .fluency: 80],
//                    comments: [.clarity: "Needs improvement", .pace: "Better pacing"],
//                    overallComment: "Good effort"
//                ),
//                analytics: RecordingAnalytics(
//                    duration: 150,
//                    wordsPerMinute: 120,
//                    silenceDuration: 15,
//                    volumeVariation: 0.7,
//                    pronunciationAccuracy: 90,
//                    transcription: "This is a random topic transcription.",
//                    keyPhrases: ["Prompt response"],
//                    improvementSuggestions: ["Enhance clarity", "Focus on tone"]
//                )
//            ),
//            Recording(
//                recordingId: 3,
//                userId: 1,
//                title: "Prepared Speech 1",
//                audioFileURL: "",
//                timestamp: wednesday, // Wednesday
//                sessionType: .preparedSpeech,
//                feedback: Feedback(
//                    feedbackId: 3,
//                    recordingId: 3,
//                    scores: [.clarity: 88, .tone: 92, .pace: 85, .fluency: 90],
//                    comments: [.tone: "Excellent modulation", .fluency: "Smooth delivery"],
//                    overallComment: "Great delivery"
//                ),
//                analytics: RecordingAnalytics(
//                    duration: 180,
//                    wordsPerMinute: 130,
//                    silenceDuration: 8,
//                    volumeVariation: 0.9,
//                    pronunciationAccuracy: 96,
//                    transcription: "Prepared speech sample transcription.",
//                    keyPhrases: ["Prepared speech"],
//                    improvementSuggestions: ["Maintain pace"]
//                )
//            ),
//            Recording(
//                recordingId: 4,
//                userId: 1,
//                title: "Read Aloud 2",
//                audioFileURL: "",
//                timestamp: monday, // Monday
//                sessionType: .readAloud,
//                feedback: Feedback(
//                    feedbackId: 1,
//                    recordingId: 1,
//                    scores: [.clarity: 85, .tone: 90, .pace: 80, .fluency: 75],
//                    comments: [.clarity: "Good clarity", .tone: "Great tone"],
//                    overallComment: "Excellent progress"
//                ),
//                analytics: RecordingAnalytics(
//                    duration: 120,
//                    wordsPerMinute: 110,
//                    silenceDuration: 10,
//                    volumeVariation: 0.8,
//                    pronunciationAccuracy: 95,
//                    transcription: "This is a sample transcription.",
//                    keyPhrases: ["Current Affairs", "Important topics"],
//                    improvementSuggestions: ["Work on pacing", "Reduce pauses"]
//                )
//            ),
//            Recording(
//                recordingId: 5,
//                userId: 1,
//                title: "Random Prompt 2",
//                audioFileURL: "",
//                timestamp: tuesday, // Tuesday
//                sessionType: .randomTopic,
//                feedback: Feedback(
//                    feedbackId: 2,
//                    recordingId: 2,
//                    scores: [.clarity: 70, .tone: 75, .pace: 85, .fluency: 80],
//                    comments: [.clarity: "Needs improvement", .pace: "Better pacing"],
//                    overallComment: "Good effort"
//                ),
//                analytics: RecordingAnalytics(
//                    duration: 150,
//                    wordsPerMinute: 120,
//                    silenceDuration: 15,
//                    volumeVariation: 0.7,
//                    pronunciationAccuracy: 90,
//                    transcription: "This is a random topic transcription.",
//                    keyPhrases: ["Prompt response"],
//                    improvementSuggestions: ["Enhance clarity", "Focus on tone"]
//                )
//            ),
//            Recording(
//                recordingId: 6,
//                userId: 1,
//                title: "Prepared Speech 2",
//                audioFileURL: "",
//                timestamp: wednesday, // Wednesday
//                sessionType: .preparedSpeech,
//                feedback: Feedback(
//                    feedbackId: 3,
//                    recordingId: 3,
//                    scores: [.clarity: 88, .tone: 92, .pace: 85, .fluency: 90],
//                    comments: [.tone: "Excellent modulation", .fluency: "Smooth delivery"],
//                    overallComment: "Great delivery"
//                ),
//                analytics: RecordingAnalytics(
//                    duration: 180,
//                    wordsPerMinute: 130,
//                    silenceDuration: 8,
//                    volumeVariation: 0.9,
//                    pronunciationAccuracy: 96,
//                    transcription: "Prepared speech sample transcription.",
//                    keyPhrases: ["Prepared speech"],
//                    improvementSuggestions: ["Maintain pace"]
//                )
//            )
//
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
}
