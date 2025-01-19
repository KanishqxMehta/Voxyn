import Foundation

// MARK: - SpeechPractice Model
enum InputMode: String {
    case typed = "Typed"
    case scanned = "Scanned"
}

struct SpeechPractice {
    var id: Int
    var inputMode: InputMode
    var title: String
    var description: String
    var originalText: String
//    var estimatedTime: Int
    var userRecording: String? // Assuming user recording is stored as a file path or URL
    var createdAt: String
}

// MARK: - SpeechPractice Data Model
class SpeechPracticeDataModel {
    // Singleton instance
    static let shared = SpeechPracticeDataModel()
    
    private var speechPractices: [SpeechPractice] = []
    private var currentID: Int = 3
    
    private init() {
        // Initialize with some sample data
        speechPractices = [
            SpeechPractice(
                id: 0,
                inputMode: .typed,
                title: "Introduction Speech",
                description: "Practice introducing yourself in formal settings.",
                originalText: "Hello, my name is John. I am a software developer from New York.",
//                estimatedTime: 5,
                userRecording: nil,
                createdAt: ""
            ),
            SpeechPractice(
                id: 1,
                inputMode: .scanned,
                title: "Interview Preparation",
                description: "Common interview questions for practice.",
                originalText: "Why do you want to work at our company?",
//                estimatedTime: 10,
//                pronunciationGuide: "why doo yoo wan-tuh wurk at owr cuhm-puh-nee?",
                userRecording: nil,
                createdAt: ""
            ),
            SpeechPractice(
                id: 2,
                inputMode: .typed,
                title: "Vacation Story",
                description: "Describe your last vacation to practice storytelling.",
                originalText: "Last summer, I went to Italy. The food and architecture were amazing.",
//                estimatedTime: 8,
//                pronunciationGuide: nil,
                userRecording: nil,
                createdAt: ""
            )
        ]
    }
    
    // MARK: - Data Access Methods
    func getAllSpeechPractices() -> [SpeechPractice] {
        return speechPractices
    }
    
    func getSpeechPractice(by title: String) -> SpeechPractice? {
        return speechPractices.first { $0.title == title }
    }
    
    func getSpeechPractice(by index: Int) -> SpeechPractice? {
        guard index >= 0 && index < speechPractices.count else { return nil }
        return speechPractices[index]
    }

    // MARK: - Add, Update and Delete Methods
    func addSpeechPractice(_ practice: SpeechPractice) {
        var newPractice = practice
        newPractice.id = currentID
        currentID += 1
        speechPractices.append(newPractice)
    }
    
    func updateSpeechPractice(_ updatedPractice: SpeechPractice) {
        if let index = speechPractices.firstIndex(where: { $0.id == updatedPractice.id }) {
            speechPractices[index] = updatedPractice
            // Print for debugging
            print("Speech practice updated: \(updatedPractice.title)")
            print("Current speeches: \(speechPractices.map { $0.title })")
        } else {
            print("Speech practice with id \(updatedPractice.id) not found")
        }
    }
    
    func printAllSpeeches() {
        print("\n--- All Speech Practices ---")
        for speech in speechPractices {
            print("ID: \(speech.id), Title: \(speech.title)")
        }
        print("-------------------------\n")
    }

//    func deleteSpeechPractice(by title: String) -> Bool {
//        if let index = speechPractices.firstIndex(where: { $0.title == title }) {
//            speechPractices.remove(at: index)
//            return true
//        }
//        return false
//    }
    
    func deleteSpeechPractice(by index: Int) -> SpeechPractice? {
        guard index >= 0 && index < speechPractices.count else { return nil }
        return speechPractices.remove(at: index)
    }
    
    // MARK: - Additional Helper Methods
//    func getPracticesCreated(on date: Date) -> [SpeechPractice] {
//        let calendar = Calendar.current
//        return speechPractices.filter {
//            calendar.isDate($0.createdAt, inSameDayAs: date)
//        }
//    }
    
    func getPracticesByMode(_ mode: InputMode) -> [SpeechPractice] {
        return speechPractices.filter { $0.inputMode == mode }
    }
}
