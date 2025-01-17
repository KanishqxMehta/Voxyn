//
//  Vocabulary.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 27/12/24.
//

import Foundation

// MARK: - Vocabulary
struct Vocabulary {
    let id: Int
    let word: String
    let partOfSpeech: String
    let definition: String
    let pronunciationText: String
    var exampleSentence: [String]
    let synonyms: [String]
    let antonyms: [String]
    let etymology: String
    var isPracticed: Bool
    let tags: [String]
}

// Practice attempt model
struct PracticeAttempt {
    let id: Int
    let wordId: Int
    let sentence: String
    let analysis: SentenceAnalysis
    let timestamp: Date
}

// MARK: - SentenceAnalysis
struct SentenceAnalysis {
    let score: Int
    let feedback: String
    let grammarCheck: String
    let contextCheck: String
    let vocabularyUsage: String
    let suggestions: [String]
}

// MARK: - Vocabulary Data Management
class VocabularyDataModel {
    // Singleton instance
    static let shared = VocabularyDataModel()
    
    // Private storage for vocabulary and practice attempts
    private var vocabularyList: [Vocabulary] = [
        Vocabulary(
            id: 1,
            word: "Ephemeral",
            partOfSpeech: "adjective",
            definition: "lasting for a very short time",
            pronunciationText: "ih-fem-er-uhl",
            exampleSentence: [
                "The ephemeral nature of cherry blossoms makes them especially precious.",
                "Social media trends are often ephemeral, lasting only a few days.",
                "The artist specialized in ephemeral installations made of ice."
            ],
            synonyms: ["transitory", "fleeting", "temporary"],
            antonyms: ["permanent", "lasting", "enduring"],
            etymology: "From Greek 'ephemeros': lasting only one day, daily (epi- \"on\" + hemera \"day\")",
            isPracticed: false,
            tags: ["nature", "time"]
        ),
        Vocabulary(
            id: 2,
            word: "Serendipity",
            partOfSpeech: "noun",
            definition: "the occurrence of events by chance in a happy or beneficial way",
            pronunciationText: "ser-en-dip-i-tee",
            exampleSentence: [
                "Meeting her was pure serendipity.",
                "The scientist’s discovery was an act of serendipity, not intention.",
                "Travel often brings moments of serendipity that become lifelong memories."
            ],
            synonyms: ["chance", "fortuity", "fluke"],
            antonyms: ["misfortune", "bad luck"],
            etymology: "Coined by Horace Walpole from Persian 'Serendip', an old name for Sri Lanka, based on a fairy tale where heroes make discoveries by accident.",
            isPracticed: true,
            tags: ["luck", "discovery"]
        ),
        Vocabulary(
            id: 3,
            word: "Ineffable",
            partOfSpeech: "adjective",
            definition: "too great or extreme to be expressed in words",
            pronunciationText: "in-ef-uh-buhl",
            exampleSentence: [
                "The beauty of the sunset was ineffable.",
                "She felt an ineffable joy upon receiving the award.",
                "Their bond was ineffable and deeply emotional."
            ],
            synonyms: ["inexpressible", "indescribable", "unspeakable"],
            antonyms: ["expressible", "describable"],
            etymology: "From Latin 'ineffabilis': in- (not) + effabilis (utterable, able to be expressed in words)",
            isPracticed: false,
            tags: ["emotion", "beauty"]
        ),
        Vocabulary(
            id: 4,
            word: "Lugubrious",
            partOfSpeech: "adjective",
            definition: "looking or sounding sad and dismal",
            pronunciationText: "loo-goo-bree-uhs",
            exampleSentence: [
                "The lugubrious music added to the somber mood.",
                "His lugubrious tone revealed his true feelings.",
                "The play featured a lugubrious protagonist."
            ],
            synonyms: ["mournful", "melancholy", "gloomy"],
            antonyms: ["cheerful", "joyful", "bright"],
            etymology: "From Latin 'lugubris': mourning, lamentation (lugere \"to mourn\")",
            isPracticed: true,
            tags: ["emotion", "mood"]
        ),
        Vocabulary(
            id: 5,
            word: "Quintessential",
            partOfSpeech: "adjective",
            definition: "representing the most perfect example of a quality or class",
            pronunciationText: "kwin-te-sen-shuhl",
            exampleSentence: [
                "She is the quintessential modern artist.",
                "This dish is a quintessential example of Italian cuisine.",
                "The movie is quintessentially romantic."
            ],
            synonyms: ["typical", "ideal", "archetypal"],
            antonyms: ["atypical", "imperfect"],
            etymology: "From Latin 'quintessentia': fifth essence (quintus \"fifth\" + essentia \"essence\") in medieval philosophy, the fifth and highest element",
            isPracticed: false,
            tags: ["perfection", "ideal"]
        )
    ]
    private var practiceAttempts: [PracticeAttempt] = []
    
    // Private initializer to enforce singleton
    private init() { }
    
    // MARK: - Vocabulary Management

    // Fetch all vocabulary
    func getAllVocabulary() -> [Vocabulary] {
        return vocabularyList
    }
    
    // Fetch a specific vocabulary by ID
    func getVocabulary(by id: Int) -> Vocabulary? {
        return vocabularyList.first { $0.id == id }
    }
    
    // Add new vocabulary
    func addVocabulary(_ word: Vocabulary) {
        vocabularyList.append(word)
    }
    
    // Delete vocabulary by ID
    func deleteVocabulary(by id: Int) {
        vocabularyList.removeAll { $0.id == id }
    }
    
    // Update isPracticed status for a vocabulary
    func markAsPracticed(wordId: Int) {
        if let index = vocabularyList.firstIndex(where: { $0.id == wordId }) {
            vocabularyList[index].isPracticed = true
        }
    }
    
    // Fetch all practiced words
    func getPracticedWords() -> [Vocabulary] {
        return vocabularyList.filter { $0.isPracticed }
    }

    // MARK: - Practice Attempts Management

    // Add a new practice attempt
    func addPracticeAttempt(_ attempt: PracticeAttempt) {
        practiceAttempts.append(attempt)
    }
    
    // Fetch all practice attempts for a specific word
    func getPracticeAttempt(for wordId: Int) -> [PracticeAttempt] {
        return practiceAttempts.filter { $0.wordId == wordId }
    }
    
    // Review user sentence (mock analysis)
    func reviewSentence(_ sentence: String) -> SentenceAnalysis {
        // Simulated analysis logic (to be replaced with real AI/ML or server-side API)
        let score = Int.random(in: 50...100)
        let feedback = "Your sentence is well-constructed but could use better context."
        let grammarCheck = "Grammar is correct."
        let contextCheck = "Context is slightly unclear."
        let vocabularyUsage = "Good use of vocabulary."
        let suggestions = ["Add more specific examples.", "Improve sentence flow."]
        
        return SentenceAnalysis(
            score: score,
            feedback: feedback,
            grammarCheck: grammarCheck,
            contextCheck: contextCheck,
            vocabularyUsage: vocabularyUsage,
            suggestions: suggestions
        )
    }
}
