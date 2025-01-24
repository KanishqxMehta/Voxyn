//
//  LessonDetailViewController.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 12/01/25.
//

import UIKit
import AVFoundation

protocol LessonDetailDelegate: AnyObject {
    func didUpdateLessonCompletion(_ lesson: Lesson)
}

class LessonDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var speakerButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var lesson: Lesson?
    weak var delegate: LessonDetailDelegate?
    private let speechSynthesizer = AVSpeechSynthesizer()
    private var isSpeaking = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        scrollView.delegate = self
    }
    
    func setupUI() {
        guard let lesson = lesson else { return }
                
        titleLabel.text = lesson.title
        contentTextView.text = lesson.fullContent
        progressView.progress = 0.0 // Start at 0
        
        updateCompleteButtonState()
        updateSpeakerButtonTitle()
    }
    
    // Update the complete button's state and appearance
    func updateCompleteButtonState() {
        guard let lesson = lesson else { return }
        
        completeButton.setTitle(lesson.isCompleted ? "Completed" : "Mark as Complete", for: .normal)
        completeButton.tintColor = lesson.isCompleted ? .systemGreen : .systemBlue
        completeButton.setTitleColor(.white, for: .normal)
    }

    
    @IBAction func completeButton(_ sender: Any) {
        guard let lessonId = lesson?.lessonId else { return }
                
        // Toggle the completion status
        LessonDataModel.shared.toggleLessonCompletion(for: lessonId)
        
        // Get the updated lesson
        if let updatedLesson = LessonDataModel.shared.getLesson(by: lessonId) {
            // Update local lesson
            self.lesson = updatedLesson
            
            // Update UI
            updateCompleteButtonState()
            
            // Notify delegate about the change
            delegate?.didUpdateLessonCompletion(updatedLesson)
        }
    }
    
    // Pronounce the text using AVSpeechSynthesizer
    func pronounceText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US") // Set language
        utterance.rate = 0.5 // Adjust speaking rate
        speechSynthesizer.speak(utterance)
    }
    
    @IBAction func playContent(_ sender: UIButton) {
        guard let text = contentTextView.text, !text.isEmpty else { return }
        if isSpeaking {
            // Stop speaking if currently speaking
            speechSynthesizer.stopSpeaking(at: .immediate)
            isSpeaking = false
        } else {
            // Start speaking the content
            pronounceText(text)
            isSpeaking = true
        }
        
        // Update the button title
        updateSpeakerButtonTitle()
    }
    
    // Update the speaker button's title
    func updateSpeakerButtonTitle() {
        let title = isSpeaking ? "speaker.slash.fill" : "speaker.wave.3.fill"
        speakerButton.setImage(UIImage(systemName: title), for: .normal)
    }
    
    // MARK: - UIScrollViewDelegate Method
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height - scrollView.bounds.height
        guard contentHeight > 0 else { return } // Avoid division by zero
        
        let offset = scrollView.contentOffset.y
        let progress = Float(offset / contentHeight)
        progressView.progress = max(0, min(progress, 1.0))
    }
    
}
