//
//  ReadAloud.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 27/12/24.
//

import Foundation


// MARK: - Genre Definition
struct Genre {
    let name: String
    let iconName: String
    let description: String
}


// MARK: - Read Aloud Genres
enum ReadAloudGenre: String, CaseIterable {
    case news = "News"
    case business = "Business"
    case technology = "Technology"
    case lifestyle = "Lifestyle"
    case health = "Health"
    
    // Helper method to get the associated genre data
    var genreData: Genre {
        switch self {
        case .news:
            return Genre(name: self.rawValue, iconName: "newspaper.fill", description: "Stay updated with current events")
        case .business:
            return Genre(name: self.rawValue, iconName: "chart.line.uptrend.xyaxis", description: "Explore business and economics")
        case .technology:
            return Genre(name: self.rawValue, iconName: "desktopcomputer", description: "Discover latest tech trends")
        case .lifestyle:
            return Genre(name: self.rawValue, iconName: "house.fill", description: "Explore daily life topics")
        case .health:
            return Genre(name: self.rawValue, iconName: "heart.fill", description: "Learn about health and wellness")
        }
    }
}

// MARK: - Read Aloud
struct ReadAloud {
    let passageId: Int
    var genre: ReadAloudGenre
    var title: String
    var selectedPassage: String
    var correctPronunciationAudioURL: String
    let estimatedSpeakingTime: Int
    var userSpokenTime: Int?
    var userRecording: Recording?
}

// MARK: - Read Aloud Data Management
class ReadAloudDataModel {
    static let shared = ReadAloudDataModel() // Singleton instance
    private var passages: [ReadAloud] = [
        // News
        ReadAloud(
            passageId: 1,
            genre: .news,
            title: "Global Climate Summit",
            selectedPassage: "World leaders gathered today for the annual Global Climate Summit, discussing urgent measures to address climate change. Representatives from over 190 countries presented their plans for reducing carbon emissions and transitioning to renewable energy sources.",
            correctPronunciationAudioURL: "climate_summit_audio.mp3",
            estimatedSpeakingTime: 120,
            userSpokenTime: nil,
            userRecording: nil
        ),
        ReadAloud(
            passageId: 2,
            genre: .news,
            title: "Tech Innovation Conference",
            selectedPassage: "The annual Tech Innovation Conference showcased groundbreaking developments in artificial intelligence and robotics. Industry leaders demonstrated new applications of machine learning in healthcare and education.",
            correctPronunciationAudioURL: "tech_conference_audio.mp3",
            estimatedSpeakingTime: 90,
            userSpokenTime: nil,
            userRecording: nil
        ),
        
        // Business
        ReadAloud(
            passageId: 3,
            genre: .business,
            title: "Market Analysis Report",
            selectedPassage: "The quarterly market analysis shows significant growth in emerging markets. Investment opportunities in renewable energy and sustainable technologies continue to expand, with notable increases in venture capital funding.",
            correctPronunciationAudioURL: "market_analysis_audio.mp3",
            estimatedSpeakingTime: 100,
            userSpokenTime: nil,
            userRecording: nil
        ),
        ReadAloud(
            passageId: 4,
            genre: .business,
            title: "Small Business Strategies",
            selectedPassage: "Small businesses are leveraging digital tools to reach wider audiences. From social media marketing to e-commerce platforms, entrepreneurs are finding innovative ways to scale their operations.",
            correctPronunciationAudioURL: "small_business_audio.mp3",
            estimatedSpeakingTime: 85,
            userSpokenTime: nil,
            userRecording: nil
        ),
        
        // Technology
        ReadAloud(
            passageId: 5,
            genre: .technology,
            title: "AI in Everyday Life",
            selectedPassage: "Artificial intelligence is transforming our daily lives, from personalized shopping experiences to advanced healthcare diagnostics. New innovations continue to redefine convenience and efficiency.",
            correctPronunciationAudioURL: "ai_everyday_audio.mp3",
            estimatedSpeakingTime: 75,
            userSpokenTime: nil,
            userRecording: nil
        ),
        ReadAloud(
            passageId: 6,
            genre: .technology,
            title: "Space Exploration Advances",
            selectedPassage: "Private companies and national space agencies are pushing the boundaries of exploration. Recent breakthroughs in reusable rockets and satellite technology promise a new era of space discovery.",
            correctPronunciationAudioURL: "space_exploration_audio.mp3",
            estimatedSpeakingTime: 110,
            userSpokenTime: nil,
            userRecording: nil
        ),
        
        // Lifestyle
        ReadAloud(
            passageId: 7,
            genre: .lifestyle,
            title: "Minimalist Living",
            selectedPassage: "Minimalist living encourages simplicity by focusing on essentials and eliminating clutter. This lifestyle promotes mental clarity, financial freedom, and environmental sustainability.",
            correctPronunciationAudioURL: "minimalist_living_audio.mp3",
            estimatedSpeakingTime: 95,
            userSpokenTime: nil,
            userRecording: nil
        ),
        ReadAloud(
            passageId: 8,
            genre: .lifestyle,
            title: "Urban Gardening",
            selectedPassage: "Urban gardening has become a popular trend in cities. People are transforming small spaces like balconies and rooftops into lush green havens, growing fresh produce at home.",
            correctPronunciationAudioURL: "urban_gardening_audio.mp3",
            estimatedSpeakingTime: 80,
            userSpokenTime: nil,
            userRecording: nil
        ),
        
        // Health
        ReadAloud(
            passageId: 9,
            genre: .health,
            title: "Mindfulness Meditation",
            selectedPassage: "Mindfulness meditation is gaining popularity for reducing stress and improving focus. Regular practice has shown significant benefits for both mental and physical health.",
            correctPronunciationAudioURL: "mindfulness_meditation_audio.mp3",
            estimatedSpeakingTime: 70,
            userSpokenTime: nil,
            userRecording: nil
        ),
        ReadAloud(
            passageId: 10,
            genre: .health,
            title: "Nutrition Trends",
            selectedPassage: "The latest nutrition trends emphasize plant-based diets and functional foods. Experts highlight the role of superfoods in boosting immunity and overall well-being.",
            correctPronunciationAudioURL: "nutrition_trends_audio.mp3",
            estimatedSpeakingTime: 90,
            userSpokenTime: nil,
            userRecording: nil
        )
    ]
    
    private init() { }
    
    // Add a New Passage
    //    func addPassage(_ passage: ReadAloud) {
    //        passages.append(passage)
    //    }
    
    // Fetch All Passages
    func getAllPassages() -> [ReadAloud] {
        return passages
    }
    
    
    func searchPassage(by passageId: Int) -> ReadAloud? {
        return passages.first { $0.passageId == passageId }
    }


    
    // Search Passages by Title
    func searchPassages(by title: String) -> [ReadAloud] {
        return passages.filter { $0.title.lowercased().contains(title.lowercased()) }
    }
    // Search Passages by Genre
    func searchPassages(byGenre genre: String) -> [ReadAloud] {
        return passages.filter { $0.genre.rawValue == genre }
    }
    
    func getAllGenres() -> [Genre] {
        return ReadAloudGenre.allCases.map { $0.genreData }
    }
    
    func getPassages(for genre: ReadAloudGenre) -> [ReadAloud] {
        return passages.filter { $0.genre == genre }
    }
    
    // Fetch All Titles for a Genre
    func getTitles(byGenre genre: ReadAloudGenre) -> [String] {
        return passages.filter { $0.genre == genre }.map { $0.title }
    }
    
}
