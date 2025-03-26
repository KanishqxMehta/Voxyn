//
//  RandomTopic.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 27/12/24.
//

import Foundation

// MARK: - Random Topic Genres
enum RandomTopicGenre: String, CaseIterable {
    case personalExperiences = "Personal Experiences"
    case currentAffairs = "Current Affairs"
    case abstractTopics = "Abstract Topics"
    case motivationalTopics = "Motivational Topics"
    
    // Helper method to get the associated genre data
    var genreData: Genre {
        switch self {
        case .personalExperiences:
            return Genre(
                name: self.rawValue,
                iconName: "person.fill",
                description: "Share and reflect on your life experiences and personal journey"
            )
        case .currentAffairs:
            return Genre(
                name: self.rawValue,
                iconName: "globe",
                description: "Engage in discussions about contemporary global events and issues"
            )
        case .abstractTopics:
            return Genre(
                name: self.rawValue,
                iconName: "lightbulb.fill",
                description: "Explore philosophical concepts and thought-provoking ideas"
            )
        case .motivationalTopics:
            return Genre(
                name: self.rawValue,
                iconName: "sparkles",
                description: "Share inspiring stories and discuss factors that drive success"
            )
        }
    }
}

// MARK: - Random Topic
struct RandomTopic {
    let topicId: Int
    var genre: RandomTopicGenre
    var title: String
    var description: String
    let minimumSpeakingTime: TimeInterval
    var userRecording: Recording?
}

// MARK: - Random Topic Data Management
class RandomTopicDataModel {
    static let shared = RandomTopicDataModel() // Singleton instance
    
    private var topics: [RandomTopic] = [
        // Personal Experiences Topics
        RandomTopic(
            topicId: 1,
            genre: .personalExperiences,
            title: "Life-Changing Moment",
            description: "Share a moment that significantly impacted your life and how it shaped who you are today. Consider discussing the lessons learned and how this experience changed your perspective.",
            minimumSpeakingTime: 180,
            userRecording: nil
        ),
        RandomTopic(
            topicId: 2,
            genre: .personalExperiences,
            title: "A Memorable Journey",
            description: "Talk about a journey or trip that left a lasting impression on you. Highlight the experiences, challenges, and emotions you encountered along the way.",
            minimumSpeakingTime: 200,
            userRecording: nil
        ),
        
        // Current Affairs Topics
        RandomTopic(
            topicId: 3,
            genre: .currentAffairs,
            title: "Technology's Impact",
            description: "Discuss how recent technological advancements are shaping society and affecting our daily lives. Consider both positive and negative impacts on work, relationships, and personal growth.",
            minimumSpeakingTime: 240,
            userRecording: nil
        ),
        RandomTopic(
            topicId: 4,
            genre: .currentAffairs,
            title: "Climate Change Challenges",
            description: "Examine the pressing issues surrounding climate change, including its causes, consequences, and what individuals and governments can do to combat it.",
            minimumSpeakingTime: 220,
            userRecording: nil
        ),
        
        // Abstract Topics
        RandomTopic(
            topicId: 5,
            genre: .abstractTopics,
            title: "Nature of Time",
            description: "Explore your thoughts about the concept of time, how it affects our decisions, and why our perception of time changes in different situations.",
            minimumSpeakingTime: 210,
            userRecording: nil
        ),
        RandomTopic(
            topicId: 6,
            genre: .abstractTopics,
            title: "The Meaning of Happiness",
            description: "Delve into the idea of happiness and what it means to different people. Discuss whether it is influenced more by external circumstances or internal mindset.",
            minimumSpeakingTime: 230,
            userRecording: nil
        ),
        
        // Motivational Topics
        RandomTopic(
            topicId: 7,
            genre: .motivationalTopics,
            title: "Overcoming Obstacles",
            description: "Share your perspectives on what makes people resilient and how challenges can be transformed into opportunities for growth and learning.",
            minimumSpeakingTime: 180,
            userRecording: nil
        ),
        RandomTopic(
            topicId: 8,
            genre: .motivationalTopics,
            title: "The Power of Discipline",
            description: "Discuss how discipline can be a key driver for success. Highlight examples of individuals or practices that showcase the benefits of consistent effort and dedication.",
            minimumSpeakingTime: 190,
            userRecording: nil
        )
    ]
    
    private init() { }
    
    // Fetch All Genres
    func getAllGenres() -> [Genre] {
        return RandomTopicGenre.allCases.map { $0.genreData }
    }
    
    // Get Topics for a specific genre
    func getTopics(for genre: RandomTopicGenre) -> [RandomTopic] {
        return topics.filter { $0.genre == genre }
    }
    
    // Search Topics by topicId
    func searchTopic(by id: Int) -> RandomTopic? {
        return topics.first { $0.topicId == id }
    }

    
    // Search Topics by Title
    func searchTopics(by title: String) -> [RandomTopic] {
        return topics.filter { $0.title.lowercased().contains(title.lowercased()) }
    }
    
    // Get all topics
    func getAllTopics() -> [RandomTopic] {
        return topics
    }
    
    // Get Titles for a Genre
    func getTitles(byGenre genre: RandomTopicGenre) -> [String] {
        return topics.filter { $0.genre == genre }.map { $0.title }
    }
    
    // Add a New Topic
    func addTopic(_ topic: RandomTopic) -> Bool {
        guard getTopic(by: topic.topicId) == nil else {
            print("Topic with this ID already exists.")
            return false
        }
        topics.append(topic)
        return true
    }
    
    // Fetch Topics by Genre
    func findTopics(by genre: RandomTopicGenre) -> [RandomTopic] {
        return topics.filter { $0.genre == genre }
    }
    
    // Fetch a Single Topic by ID
    func getTopic(by topicId: Int) -> RandomTopic? {
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
    
    // Fetch All Genres
    func getAllGenres() -> [RandomTopicGenre] {
        // Return unique genres by filtering the `passages`
        let genres = topics.map { $0.genre }
        return Array(Set(genres)).sorted { $0.rawValue < $1.rawValue }
    }

}
