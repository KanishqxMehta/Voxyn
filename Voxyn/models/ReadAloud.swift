//
//  ReadAloud.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 27/12/24.
//

import Foundation

// MARK: - Read Aloud Genres
enum ReadAloudGenre: String {
    case news = "News"
    case business = "Business"
    case technology = "Technology"
    case lifestyle = "Lifestyle"
    case health = "Health"
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
    private var passages: [ReadAloud] = [] // Array to store passages
    
    private init() { }
    
    // Add a New Passage
    //    func addPassage(_ passage: ReadAloud) {
    //        passages.append(passage)
    //    }
    
    // Fetch All Passages
    func getAllPassages() -> [ReadAloud] {
        return passages
    }
    
    // Search Passages by Title
    func searchPassages(by title: String) -> [ReadAloud] {
        return passages.filter { $0.title.lowercased().contains(title.lowercased()) }
    }
    // Search Passages by Genre
    func searchPassages(byGenre genre: String) -> [ReadAloud] {
        return passages.filter { $0.genre.rawValue == genre }
    }
    // Fetch All Genres
    func getAllGenres() -> [ReadAloudGenre] {
        // Return unique genres by filtering the `passages`
        let genres = passages.map { $0.genre }
        return Array(Set(genres)).sorted { $0.rawValue < $1.rawValue }
    }
    
    // Fetch All Titles for a Genre
    func getTitles(byGenre genre: ReadAloudGenre) -> [String] {
        return passages.filter { $0.genre == genre }.map { $0.title }
    }
    
}
