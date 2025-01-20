//
//  User.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 27/12/24.
//

import Foundation

// MARK: - User
import Foundation

// MARK: - User
struct User {
    var userId: Int
    var firstName: String
    var lastName: String
    var email: String
    var dob: Date
    var profileImageURL: String?
    var accountCreatedOn: Date
    var progress: Progress
}

// MARK: - User Data Management
// MARK: - User Data Management
class UserDataModel {
    static let shared = UserDataModel() // Singleton instance
    private var currentUser: User?

    private init() {
        // Initialize with a sample user
        currentUser = User(
            userId: 1,
            firstName: "Voxite",
            lastName: "",
            email: "voxite@gmail.com",
            dob: Calendar.current.date(from: DateComponents(year: 2004, month: 4, day: 6)) ?? Date(),
            profileImageURL: nil,
            accountCreatedOn: Date(),
            progress: Progress(
                userId: 1,
                totalPracticeTime: TimeInterval(),
                completedLessons: 2,
                practicedVocabulary: 4,
                recordingsCount: 2
            )
        )
    }

    // Add or Set the Current User
    func setUser(_ user: User) {
        currentUser = user
    }

    // Fetch the Current User
    func getUser() -> User? {
        return currentUser
    }

    // Update User Details (First Name, Last Name, DOB, Email)
    func updateUserDetails(newFirstName: String?, newLastName: String?, newDob: Date?, newEmail: String?) -> Bool {
        guard var user = currentUser else {
            print("No user found.")
            return false
        }

        // Update First Name
        if let newFirstName = newFirstName, !newFirstName.isEmpty {
            user.firstName = newFirstName
        }

        // Update Last Name
        if let newLastName = newLastName, !newLastName.isEmpty {
            user.lastName = newLastName
        }

        // Update DOB
        if let newDob = newDob {
            user.dob = newDob
        }

        // Update Email
        if let newEmail = newEmail {
            user.email = newEmail
        }

        // Save updated user back to the current user
        currentUser = user
        return true
    }

    // Clear Current User (Log Out)
    func clearUser() {
        currentUser = nil
    }
}

// MARK: - Progress Implementation
struct Progress {
    let userId: Int
    var totalPracticeTime: TimeInterval
    var completedLessons: Int
    var practicedVocabulary: Int
    var recordingsCount: Int
    
    // Computed properties for progress calculation
    var lessonProgress: Double {
        let totalLessons = LessonDataModel.shared.getAllLessons().count
        guard totalLessons > 0 else { return 0.0 }
        return Double(completedLessons) / Double(totalLessons) * 100
    }
    
    var vocabularyProgress: Double {
        let totalVocabulary = VocabularyDataModel.shared.getAllVocabulary().count
        guard totalVocabulary > 0 else { return 0.0 }
        return Double(practicedVocabulary) / Double(totalVocabulary) * 100
    }
    
    // New: Track category-wise improvements
    var categoryProgress: [FeedbackCategory: Double] {
        // Calculate average scores for each category from recordings
        let recordings = RecordingDataModel.shared.findRecordings(by: userId)
        var categorySums: [FeedbackCategory: (total: Double, count: Int)] = [:]
        
        recordings.forEach { recording in
            recording.feedback.scores.forEach { category, score in
                let current = categorySums[category] ?? (total: 0, count: 0)
                categorySums[category] = (total: current.total + Double(score),
                                       count: current.count + 1)
            }
        }
        
        return categorySums.mapValues { $0.count > 0 ? $0.total / Double($0.count) : 0 }
    }
    
    
    // Overall progress considering different aspects
    var overallProgress: Double {
        let weights: [Double] = [0.4, 0.3, 0.3] // Lessons, Vocabulary, Practice time
        let normalizedPracticeTime = min(totalPracticeTime / (3600 * 10), 1.0) * 100 // Normalize to 10 hours max
        
        return (lessonProgress * weights[0] +
                vocabularyProgress * weights[1] +
                normalizedPracticeTime * weights[2]) / 100
    }
}
