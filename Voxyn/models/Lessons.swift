//
//  Lessons.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 27/12/24.
//
//
import Foundation


// MARK: - Lesson Model
struct Lesson {
    let lessonId: Int
    var title: String
    var shortDescription: String  // For table view preview
    var fullContent: String       // For detail view
    var audioURL: String?
    var duration: TimeInterval    // In minutes
    var isCompleted: Bool
    
    // Computed property for formatting duration
    var formattedDuration: String {
        return "\(Int(duration)) min read"
    }
}

// MARK: - Lesson Data Management
class LessonDataModel {
    static let shared = LessonDataModel()
    
    private var lessons: [Lesson] = [
        Lesson(
            lessonId: 1,
            title: "Public Speaking Basics",
            shortDescription: "Master the fundamentals of public speaking and learn to engage your audience effectively.",
            fullContent: """
            Public speaking is a powerful skill that can shape how you are perceived and how your message impacts others. 
            
            Key points covered in this lesson:
            1. Understanding your audience
            2. Structuring your speech
            3. Body language and voice modulation
            4. Handling nervousness
            5. Engaging with your audience
            
            Practice exercises and tips included.
            Public speaking is a powerful skill that can shape how you are perceived and how your message impacts others. 
            
            Key points covered in this lesson:
            1. Understanding your audience
            2. Structuring your speech
            3. Body language and voice modulation
            4. Handling nervousness
            5. Engaging with your audience
            
            Practice exercises and tips included.
            Public speaking is a powerful skill that can shape how you are perceived and how your message impacts others. 
            
            Key points covered in this lesson:
            1. Understanding your audience
            2. Structuring your speech
            3. Body language and voice modulation
            4. Handling nervousness
            5. Engaging with your audience
            
            Practice exercises and tips included.
            """,
            audioURL: "lesson1_audio.mp3",
            duration: 10,
            isCompleted: false
        ),
        Lesson(
            lessonId: 1,
            title: "Public Speaking Basics",
            shortDescription: "Master the fundamentals of public speaking and learn to engage your audience effectively.",
            fullContent: """
            Public speaking is a powerful skill that can shape how you are perceived and how your message impacts others. 
            
            Key points covered in this lesson:
            1. Understanding your audience
            2. Structuring your speech
            3. Body language and voice modulation
            4. Handling nervousness
            5. Engaging with your audience
            
            Practice exercises and tips included.
            """,
            audioURL: "lesson1_audio.mp3",
            duration: 10,
            isCompleted: true
        ),
        Lesson(
            lessonId: 1,
            title: "Public Speaking Basics",
            shortDescription: "Master the fundamentals of public speaking and learn to engage your audience effectively.",
            fullContent: """
            Public speaking is a powerful skill that can shape how you are perceived and how your message impacts others. 
            
            Key points covered in this lesson:
            1. Understanding your audience
            2. Structuring your speech
            3. Body language and voice modulation
            4. Handling nervousness
            5. Engaging with your audience
            
            Practice exercises and tips included.
            """,
            audioURL: "lesson1_audio.mp3",
            duration: 10,
            isCompleted: false
        ),
    ]
    
    private init() {}
    
    // MARK: - Data Access Methods
    func getAllLessons() -> [Lesson] {
        return lessons
    }
    
    func getLesson(by id: Int) -> Lesson? {
        return lessons.first { $0.lessonId == id }
    }
    
    func toggleLessonCompletion(for id: Int) {
        if let index = lessons.firstIndex(where: { $0.lessonId == id }) {
            lessons[index].isCompleted.toggle()
        }
    }
    
    func getCompletedLessons() -> [Lesson] {
        return lessons.filter { $0.isCompleted }
    }
    
    func getProgress() -> Double {
        let completedCount = Double(getCompletedLessons().count)
        let totalCount = Double(lessons.count)
        return (completedCount / totalCount) * 100
    }
}
