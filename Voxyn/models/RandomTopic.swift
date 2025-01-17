//
//  RandomTopic.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 27/12/24.
//

import Foundation

// MARK: - Random Topic Genres
enum RandomTopicGenre: String {
    case personalExperiences = "Personal Experiences"
    case currentAffairs = "Current Affairs"
    case abstractTopics = "Abstract Topics"
    case motivationalTopics = "Motivational Topics"
}

// MARK: - Random Topic Details
struct RandomTopicDetails {
    let genre: RandomTopicGenre // Genre of the random topic
    let topicId: Int // Unique identifier for the topic
    let topicTitle: String // Title of the topic
    let description: String // Brief description or details about the topic
    let minimumSpeakingTime: TimeInterval // Minimum time user should practice
    var userRecording: Recording?
}

// MARK: - Random Topic Data Management
class RandomTopicDataModel {
    static let shared = RandomTopicDataModel() // Singleton instance
    private var topics: [RandomTopicDetails] = [] // Array to store topics
    
    private init() { }
    
    // Add a New Topic
    func addTopic(_ topic: RandomTopicDetails) -> Bool {
        guard getTopic(by: topic.topicId) == nil else {
            print("Topic with this ID already exists.")
            return false
        }
        topics.append(topic)
        return true
    }
    
    // Fetch All Topics
    func getAllTopics() -> [RandomTopicDetails] {
        return topics
    }
    
    // Fetch Topics by Genre
    func findTopics(by genre: RandomTopicGenre) -> [RandomTopicDetails] {
        return topics.filter { $0.genre == genre }
    }
    
    // Fetch a Single Topic by ID
    func getTopic(by topicId: Int) -> RandomTopicDetails? {
        return topics.first { $0.topicId == topicId }
    }
    
    // Delete a Topic by ID
    func deleteTopic(by topicId: Int) -> Bool {
        if let index = topics.firstIndex(where: { $0.topicId == topicId }) {
            topics.remove(at: index)
            return true
        }
        print("Topic with this ID not found.")
        return false
    }
    
    // Search Topics by Title
    func searchTopics(by title: String) -> [RandomTopicDetails] {
        return topics.filter { $0.topicTitle.lowercased().contains(title.lowercased()) }
    }
    
    // Fetch All Genres
    func getAllGenres() -> [RandomTopicGenre] {
        // Return unique genres by filtering the `passages`
        let genres = topics.map { $0.genre }
        return Array(Set(genres)).sorted { $0.rawValue < $1.rawValue }
    }

    // Fetch All Titles for a Genre
    func getTitles(byGenre genre: RandomTopicGenre) -> [String] {
        return topics.filter { $0.genre == genre }.map { $0.topicTitle }
    }
}
