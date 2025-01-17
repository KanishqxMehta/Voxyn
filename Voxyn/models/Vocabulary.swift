//
//  Vocabulary.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 27/12/24.
//

import Foundation

// MARK: - Vocabulary
struct Vocabulary {
    let wordId: Int
    var word: String
    var definition: String
    var pronunciationTextForm: String
    var exampleSentence: [String]
    var userPractice: [PracticeAttempt]  // Track multiple practice attempts
    var isPracticed: Bool
    
    // Computed property to get latest practice
    var latestPractice: PracticeAttempt? {
        return userPractice.last
    }
}

// MARK: - PracticeAttempt
struct PracticeAttempt {
    let timestamp: Date
    let sentence: String
    let analysis: SentenceAnalysis
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
    static let shared = VocabularyDataModel()
    private var vocabulary: [Vocabulary] = []

    private init() { }

    func getAllVocabulary() -> [Vocabulary] {
        return self.vocabulary
    }

    func getVocabulary(by wordId: Int) -> Vocabulary? {
        return vocabulary.first { $0.wordId == wordId }
    }

    func addVocabulary(_ word: Vocabulary) {
        vocabulary.append(word)
    }

    func findPracticedWords() -> [Vocabulary] {
        return vocabulary.filter { $0.isPracticed }
    }
    
    func searchVocabulary(by word: String) -> [Vocabulary] {
        return vocabulary.filter { $0.word.localizedCaseInsensitiveContains(word) }
    }
}

//
//  Models.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 11/12/24.
//

import Foundation

struct VocabularyWord {
    let word: String
    let pronunciation: String
    let definition: String
    let examples: [String]
}

let vocabularyWords: [VocabularyWord] = [
    VocabularyWord(
        word: "Ephemeral",
        pronunciation: "ih-fem-er-uhl",
        definition: "lasting for a very short time",
        examples: [
            "The ephemeral nature of cherry blossoms makes them especially precious.",
            "Social media trends are often ephemeral, lasting only a few days.",
            "The artist specialized in ephemeral installations made of ice."
        ]
    ),
    VocabularyWord(
        word: "Serendipity",
        pronunciation: "ser-en-dip-i-tee",
        definition: "the occurrence of events by chance in a happy or beneficial way",
        examples: [
            "Meeting her was pure serendipity.",
            "The scientist’s discovery was an act of serendipity, not intention.",
            "Travel often brings moments of serendipity that become lifelong memories."
        ]
    ),
    VocabularyWord(
        word: "Ineffable",
        pronunciation: "in-ef-uh-buhl",
        definition: "too great or extreme to be expressed in words",
        examples: [
            "The beauty of the sunset was ineffable.",
            "She felt an ineffable joy upon receiving the award.",
            "Their bond was ineffable and deeply emotional."
        ]
    ),
    VocabularyWord(
        word: "Lugubrious",
        pronunciation: "loo-goo-bree-uhs",
        definition: "looking or sounding sad and dismal",
        examples: [
            "The lugubrious music added to the somber mood.",
            "His lugubrious tone revealed his true feelings.",
            "The play featured a lugubrious protagonist."
        ]
    ),
    VocabularyWord(
        word: "Quintessential",
        pronunciation: "kwin-te-sen-shuhl",
        definition: "representing the most perfect example of a quality or class",
        examples: [
            "She is the quintessential modern artist.",
            "This dish is a quintessential example of Italian cuisine.",
            "The movie is quintessentially romantic."
        ]
    ),
    VocabularyWord(
        word: "Resplendent",
        pronunciation: "ri-splen-duhnt",
        definition: "shining brilliantly; gleaming",
        examples: [
            "The bride looked resplendent in her wedding gown.",
            "The resplendent decorations lit up the hall.",
            "The sunset was resplendent with hues of orange and pink."
        ]
    ),
    VocabularyWord(
        word: "Ubiquitous",
        pronunciation: "yoo-bik-wi-tuhs",
        definition: "present, appearing, or found everywhere",
        examples: [
            "Smartphones have become ubiquitous in modern society.",
            "His influence was ubiquitous throughout the company.",
            "The scent of jasmine was ubiquitous in the garden."
        ]
    ),
    VocabularyWord(
        word: "Vicarious",
        pronunciation: "vahy-kair-ee-uhs",
        definition: "experienced through the feelings or actions of another person",
        examples: [
            "She lived vicariously through her daughter’s adventures.",
            "Reading books allows for vicarious experiences.",
            "He took vicarious pleasure in his friend’s success."
        ]
    ),
    VocabularyWord(
        word: "Zephyr",
        pronunciation: "zef-er",
        definition: "a soft gentle breeze",
        examples: [
            "A zephyr stirred the leaves on the trees.",
            "The zephyr brought a refreshing coolness to the afternoon.",
            "They enjoyed the zephyr while walking along the beach."
        ]
    ),
    VocabularyWord(
        word: "Eloquent",
        pronunciation: "el-uh-kwuhnt",
        definition: "fluent or persuasive in speaking or writing",
        examples: [
            "Her speech was eloquent and moving.",
            "He delivered an eloquent argument in favor of change.",
            "The writer’s eloquent prose captivated readers."
        ]
    ),
    VocabularyWord(
        word: "Pernicious",
        pronunciation: "per-nish-uhs",
        definition: "having a harmful effect, especially in a gradual or subtle way",
        examples: [
            "The pernicious influence of social media was discussed.",
            "His pernicious habits led to serious health issues.",
            "Rumors can have a pernicious impact on reputations."
        ]
    ),
    VocabularyWord(
        word: "Labyrinthine",
        pronunciation: "lab-uh-rin-thine",
        definition: "complicated; intricate and confusing",
        examples: [
            "The building’s labyrinthine layout made it hard to navigate.",
            "They explored the labyrinthine streets of the old city.",
            "The plot of the novel was labyrinthine and mysterious."
        ]
    ),
    VocabularyWord(
        word: "Ebullient",
        pronunciation: "ih-buhl-yuhnt",
        definition: "cheerful and full of energy",
        examples: [
            "Her ebullient personality made her the life of the party.",
            "The crowd was ebullient after their team’s victory.",
            "He greeted everyone with an ebullient smile."
        ]
    ),
    VocabularyWord(
        word: "Voracious",
        pronunciation: "voh-ray-shuhs",
        definition: "wanting or devouring great quantities of food",
        examples: [
            "He had a voracious appetite after the workout.",
            "She was a voracious reader, finishing books quickly.",
            "The animal had a voracious hunger after hibernation."
        ]
    )
]
