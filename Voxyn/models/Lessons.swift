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
            title: "Public Speaking Fundamentals",
            shortDescription: "Master the core principles of effective public speaking and overcome stage fright.",
            fullContent: """
            Public speaking is one of the most valuable skills you can develop in today's interconnected world. This comprehensive lesson will guide you through the essential elements of becoming a confident and engaging public speaker.

            1. Understanding Your Fear
            Public speaking anxiety, or glossophobia, affects up to 75% of people. It's crucial to understand that this fear is natural and manageable. The first step is acknowledging that even experienced speakers sometimes feel nervous - it's your body's way of preparing for an important event.

            Key Strategies for Managing Speaking Anxiety:
            • Practice deep breathing exercises before speaking
            • Arrive early to familiarize yourself with the space
            • Focus on your message rather than your nervousness
            • Prepare thoroughly to build confidence
            • Start with smaller groups to build experience

            2. Crafting Your Message
            Every great speech starts with a clear message. Your content should follow the "Tell them" principle:
            - Tell them what you're going to tell them (Introduction)
            - Tell them (Main Content)
            - Tell them what you told them (Conclusion)

            Structure your content with:
            • A compelling opening hook
            • 3-5 main points
            • Supporting evidence and examples
            • Clear transitions between sections
            • A memorable conclusion

            3. Delivery Techniques
            Your delivery can make or break your speech. Focus on:

            Voice Modulation:
            • Vary your pitch to maintain interest
            • Adjust volume for emphasis
            • Use strategic pauses for impact
            • Speak at a measured pace

            Body Language:
            • Maintain open posture
            • Use natural hand gestures
            • Make appropriate eye contact
            • Move purposefully in your space

            4. Engaging Your Audience
            Create an interactive experience by:
            • Asking rhetorical questions
            • Using relevant examples
            • Incorporating audience participation
            • Responding to non-verbal feedback
            • Adding appropriate humor

            5. Practice Methodology
            Effective practice is crucial:
            • Record yourself speaking
            • Practice in front of a mirror
            • Use a timer to manage length
            • Rehearse with a test audience
            • Practice handling interruptions

            6. Visual Aids
            When using visual supports:
            • Keep slides simple and clear
            • Use high-quality images
            • Include relevant data visualization
            • Ensure text is readable
            • Practice with your equipment

            Remember: Great speakers aren't born - they're made through practice and persistence. Start small, focus on improvement, and celebrate your progress along the way.

            Practice Exercises:
            1. Record a 2-minute introduction about yourself
            2. Practice the same speech standing and sitting
            3. Time yourself giving the speech at different paces
            4. Present to a friend and ask for feedback
            5. Try speaking with and without notes

            Additional Resources:
            • Join local speaking clubs
            • Watch TED talks for inspiration
            • Read books on public speaking
            • Attend speaking workshops
            • Find a speaking mentor
            """,
            audioURL: "lesson1_audio.mp3",
            duration: 15,
            isCompleted: false
        ),
        Lesson(
            lessonId: 2,
            title: "Voice Modulation Mastery",
            shortDescription: "Learn to control and enhance your voice for maximum impact in presentations.",
            fullContent: """
            Voice modulation is the art of controlling and varying your voice to create impact and maintain audience engagement. This lesson explores advanced techniques for mastering your vocal delivery.

            1. Understanding Voice Components
            Your voice consists of several key elements:
            • Pitch - The highness or lowness of your voice
            • Volume - The loudness or softness
            • Pace - The speed of delivery
            • Tone - The emotional quality
            • Resonance - The richness and depth

            2. Breath Control
            Proper breathing is fundamental to voice control:
            • Practice diaphragmatic breathing
            • Maintain consistent breath support
            • Control exhale for longer phrases
            • Use breath for natural pauses
            • Build breath stamina

            3. Pitch Variation
            Learn to vary your pitch effectively:
            • Identify your natural pitch range
            • Use higher pitch for excitement
            • Lower pitch for authority
            • Match pitch to content
            • Avoid monotone delivery

            4. Dynamic Range
            Develop control over volume:
            • Project without straining
            • Use whispers for emphasis
            • Build to crescendos
            • Control sudden volume changes
            • Match room acoustics

            5. Emotional Expression
            Connect voice to emotions:
            • Happy - Light, upward inflection
            • Serious - Deeper, measured tone
            • Excited - Quick, varied pitch
            • Confident - Strong, steady tone
            • Empathetic - Warm, gentle tone

            6. Speech Rhythm
            Master the timing of speech:
            • Vary pace for interest
            • Use pauses effectively
            • Create speech patterns
            • Match content rhythm
            • Build tension and release

            7. Articulation Exercises
            Practice these daily:
            • Tongue twisters
            • Vowel stretching
            • Consonant precision
            • Lip trills
            • Jaw relaxation

            8. Common Problems and Solutions
            Address these issues:
            • Vocal fry
            • Breathiness
            • Nasality
            • Mumbling
            • Strain

            9. Voice Care
            Maintain vocal health:
            • Stay hydrated
            • Avoid strain
            • Warm up properly
            • Rest when needed
            • Manage acid reflux

            10. Advanced Techniques
            Master these skills:
            • Color words with emotion
            • Create vocal variety
            • Use silence effectively
            • Build vocal strength
            • Develop resonance

            Practice Routines:
            Morning Warm-up:
            1. Breathing exercises
            2. Humming scales
            3. Tongue twisters
            4. Pitch slides
            5. Resonance building

            Remember: Your voice is a powerful tool that requires regular maintenance and practice. The more you work with these techniques, the more natural they become.
            """,
            audioURL: "lesson2_audio.mp3",
            duration: 12,
            isCompleted: false
        ),
        Lesson(
            lessonId: 3,
            title: "Body Language Essentials",
            shortDescription: "Discover how to use non-verbal communication to enhance your message delivery.",
            fullContent: """
            Body language accounts for over 50% of communication. Understanding and mastering non-verbal cues can dramatically improve your speaking effectiveness.

            1. Posture Fundamentals
            Proper posture communicates confidence:
            • Stand straight but relaxed
            • Keep shoulders back
            • Distribute weight evenly
            • Maintain stability
            • Allow natural movement

            2. Hand Gestures
            Effective gesturing enhances your message:
            • Use purposeful movements
            • Match gesture to content
            • Avoid repetitive motions
            • Keep gestures natural
            • Practice common gestures

            [Content continues with detailed sections on facial expressions, movement patterns, audience interaction, cultural considerations, and practical exercises...]
            """,
            audioURL: "lesson3_audio.mp3",
            duration: 18,
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
    
    func addLesson(_ lesson: Lesson) {
        guard lessons.contains(where: { $0.lessonId == lesson.lessonId }) == false else {
            print("Lesson with ID \(lesson.lessonId) already exists.")
            return
        }
        lessons.append(lesson)
    }

    func toggleLessonCompletion(for id: Int) {
        if let index = lessons.firstIndex(where: { $0.lessonId == id }) {
            lessons[index].isCompleted.toggle()
        }
    }
    
    func deleteLesson(by id: Int) {
        lessons.removeAll { $0.lessonId == id }
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
