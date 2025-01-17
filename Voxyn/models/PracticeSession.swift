//
//  PracticeSession.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 27/12/24.
//

import Foundation

// MARK: -Practice Options
enum SessionType {
    case readAloud, randomTopic, preparedSpeech
}

struct PracticeSession {
    let sessionId: Int // Use let for the session ID as it should be fixed once created
    let sessionType: SessionType // Enum to specify if it's Read Aloud, Random Topic, or Prepared Speech
    let selectedText: String // The text or topic the user practices
    let createdAt: Date
}

