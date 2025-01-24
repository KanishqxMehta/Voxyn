//
//  User.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 27/12/24.
//

import Foundation
import Security
import Foundation
import CommonCrypto

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
    var password: String
   // var progress: Progress
}

// MARK: - User Data Management
// MARK: - User Data Management
class UserDataModel {
    static let shared = UserDataModel() // Singleton instance
    private var currentUser: User?
    
    private var users: [User] = [
        User(
            userId: 0,
            firstName: "Voxite",
            lastName: "",
            email: "voxite@gmail.com",
            dob: Calendar.current.date(from: DateComponents(year: 2004, month: 4, day: 6)) ?? Date(),
            profileImageURL: nil,
            accountCreatedOn: Date(),
            password: "123456"
        ),
    ]
    
    private init() {
        // Initialize with a sample user
//        currentUser = User(
//            userId: 1,
//            firstName: "Voxite",
//            lastName: "",
//            email: "voxite@gmail.com",
//            dob: Calendar.current.date(from: DateComponents(year: 2004, month: 4, day: 6)) ?? Date(),
//            profileImageURL: nil,
//            accountCreatedOn: Date(),
//            password: "123456"
//        )
    }
    
    
    
    // Add to UserDataModel

    func signUp(firstName: String, lastName: String, email: String, dob: Date, password: String) -> Bool {
        // Validate input
        guard !firstName.isEmpty, !email.isEmpty, !password.isEmpty else {
            print("Invalid input fields")
            return false
        }

        // Hash the password for security (use Keychain in real apps)
        let hashedPassword = hashPassword(password)

        // Create new user
        let newUser = User(
            userId: users.count,  // Generate a unique ID (can be based on your logic)
            firstName: firstName,
            lastName: lastName,
            email: email,
            dob: dob,
            profileImageURL: nil,  // Optional
            accountCreatedOn: Date(),
            password: password
        )
        
        users.append(newUser)
        
        // Store new user in data model
//        setUser(newUser)

        // Save the password securely using Keychain (for now using UserDefaults for simplicity)
       // savePasswordToKeychain(email: email, password: hashedPassword)

        return true
    }
    
    func login(email: String, password: String) -> Bool {
          // Check if user with the given email and password exists
          for user in users {
              if user.email == email && user.password == password {
                  //return user
                  setUser(user)// Return the user if credentials are correct
                  print(user.email)
                  print(user.password)
                  return true
              }
          }
          return false // Return nil if no matching user is found
      }
  
    
//    func savePasswordToKeychain(email: String, password: String) {
//        let passwordData = password.data(using: .utf8)!
//        
//        let query: [CFString: Any] = [
//            kSecClass: kSecClassGenericPassword,
//            kSecAttrAccount: email,
//            kSecValueData: passwordData
//        ]
//        
//        SecItemAdd(query as CFDictionary, nil)
//    }
    
    func hashPassword(_ password: String) -> String {
        // Convert password string to Data
        let passwordData = password.data(using: .utf8)!
        
        // Create a mutable buffer to hold the hash result
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        
        // Perform the SHA-256 hash
        _ = passwordData.withUnsafeBytes {
            CC_SHA256($0.baseAddress, CC_LONG(passwordData.count), &hash)
        }
        
        // Convert hash to hexadecimal string
        let hashString = hash.map { String(format: "%02x", $0) }.joined()
        
        return hashString
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
    let progressId: Int
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
