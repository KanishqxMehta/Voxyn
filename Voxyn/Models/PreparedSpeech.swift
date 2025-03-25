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
                title: "Who I Am and What I Bring to the Table",
                description: "A concise introduction to showcase your skills, experiences, and aspirations during a job interview.",
                originalText: "Good morning, I’m Alex, a software engineer with a passion for developing efficient and innovative solutions. I specialize in web development and have experience leading projects that increased user engagement by 20%. I value collaboration and thrive in team environments. My goal is to bring both creativity and strategic thinking to your company, contributing to impactful projects that make a difference.",
//                estimatedTime: 5,
                userRecording: nil,
                createdAt: ""
            ),
            SpeechPractice(
                id: 1,
                inputMode: .scanned,
                title: "Grateful for the Honor",
                description: "A short and gracious speech to thank those who supported you in receiving an award.",
                originalText: "Thank you so much for this incredible honor. I am deeply humbled to be recognized and owe this achievement to the mentors and teammates who believed in me. This award is a reminder of the power of collaboration and dedication. I hope to continue making meaningful contributions and inspiring others just as I have been inspired by those around me. Thank you!",
//                estimatedTime: 10,
//                pronunciationGuide: "why doo yoo wan-tuh wurk at owr cuhm-puh-nee?",
                userRecording: nil,
                createdAt: ""
            ),
            SpeechPractice(
                id: 2,
                inputMode: .typed,
                title: "Driving Innovation Together",
                description: "A motivational speech to encourage teamwork and creativity during a meeting.",
                originalText: "Good morning, team. As we embark on this new project, I want to emphasize the importance of collaboration and innovation. Every idea matters, and together, we have the potential to create something truly exceptional. Let’s embrace challenges as opportunities to grow and push boundaries. I believe in this team’s talent and determination, and I am excited to see what we will achieve. Let’s make it happen!",
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
