//
//  VocabularyViewController.swift
//  VocabularyScreen
//
//  Created by student-2 on 13/01/25.
//

import UIKit
import AVFoundation

class PracticeViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate  {

    // MARK: - Properties
    private var timer: Timer?
    private var isRecording = false

    @IBOutlet var contentView: UIView!
    @IBOutlet var curveContainerEdges: [UIView]!
    @IBOutlet var estimatedTimeView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var bookSymbol: UIView!
    @IBOutlet weak var recordingSlider: UISlider!

    @IBOutlet weak var analyzingYourSpeech: UILabel!
    @IBOutlet weak var readyView: UIView!
    @IBOutlet weak var waveRecordingView: UIView!
    @IBOutlet weak var recordingView: UIView!
    @IBOutlet var waves: [UIView]!

    @IBOutlet var areasOfImprovementView: UIView!

    @IBOutlet var feedbackView1: UIView!
    @IBOutlet var feedbackView2: UIView!
    @IBOutlet var speechToTextView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet private weak var readInstructionLabel: UILabel!
    @IBOutlet private weak var passageTextView: UITextView!
    @IBOutlet private weak var estimatedSpeakingTimeLabel: UILabel!
    @IBOutlet private weak var speakingTimeLabel: UILabel!
    
    @IBOutlet var areaOfImprovementLabel: UILabel!
    @IBOutlet var speechToTextLabel: UILabel!
    
    @IBOutlet var clarityProgressBar: UIProgressView!
    @IBOutlet var paceProgressBar: UIProgressView!
    @IBOutlet var toneProgressBar: UIProgressView!
    @IBOutlet var fluencyProgressBar: UIProgressView!
    
    @IBOutlet var clarityPercentLabel: UILabel!
    @IBOutlet var pacePercentLabel: UILabel!
    @IBOutlet var tonePercentLabel: UILabel!
    @IBOutlet var fluencyPercentLabel: UILabel!
    
    var dataType: DataType?
    var selectedData: Any?
    
    enum DataType {
        case readAloud
        case randomTopic
        case preparedSpeech
    }

    var waveBars: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
//        setupAudioSession()
//        configureAudioRecorder()
    }

    // MARK: - Setup Methods
    private func setupInitialState() {
        // Initial UI setup
        analyzingYourSpeech.isHidden = true
        pauseButton.isHidden = true
        recordingView.isHidden = true
        waveRecordingView.isHidden = true

        // Configure slider
//        recordingSlider.setThumbImage(UIImage(named: "Ellipse 27"), for: .normal)
//        recordingSlider.minimumValue = 0
//        recordingSlider.maximumValue = 1
//        recordingSlider.value = 0
        areasOfImprovementView.isHidden = true
        feedbackView1.isHidden = true
        feedbackView2.isHidden = true
        speechToTextView.isHidden = true
        roundEdgesOfViews()
//        startWaveAnimation()
        updateContentBasedOnDataType()
    }
    
    // MARK: - Content Update Methods
    private func updateContentBasedOnDataType() {
        // First, set the general instruction based on data type
        switch dataType {
        case .readAloud:
            // For read aloud, we'll keep the default instruction
            readInstructionLabel.text = "Read the below text to get feedback"
            
        case .randomTopic:
            // For random topic, we'll modify the instruction
            readInstructionLabel.text = "Speak about the following topic"
        case .preparedSpeech:
            readInstructionLabel.text = "Read out your speech"
        case .none:
            print("No data type specified")
            return
        }
        
        // Then update the content based on the specific data
        if let readAloudData = selectedData as? ReadAloud {
            configureReadAloudContent(readAloudData)
        } else if let topicData = selectedData as? RandomTopic {
            configureRandomTopicContent(topicData)
        } else if let preparedSpeechData = selectedData as? SpeechPractice {
            configurePreparedSpeechContent(preparedSpeechData)
        }
    }

    
    private func configureReadAloudContent(_ data: ReadAloud) {
        // Update UI for read aloud passage
        title = data.title // Set navigation title
        passageTextView.text = data.selectedPassage
        speakingTimeLabel.text = "Estimated Speaking Time:"
        speechToTextLabel.text = data.selectedPassage
        estimatedSpeakingTimeLabel.text = "\(data.estimatedSpeakingTime) seconds"

    }
    
    private func configureRandomTopicContent(_ topic: RandomTopic) {
        // Update UI for random topic
        title = topic.title // Set navigation title
        passageTextView.text = topic.description
        speakingTimeLabel.text = "Minimum Speaking Time"
        speechToTextLabel.text = topic.description
        estimatedSpeakingTimeLabel.text = "\(topic.minimumSpeakingTime) seconds"
    }

    private func configurePreparedSpeechContent(_ speech: SpeechPractice) {
        // Update UI for random topic
        title = speech.title // Set navigation title
        passageTextView.text = speech.originalText
        speakingTimeLabel.text = "Minimum Speaking Time"
        speechToTextLabel.text = speech.originalText
        estimatedSpeakingTimeLabel.text = "\(50) seconds"
//        estimatedSpeakingTimeLabel.text = "\(topic.minimumSpeakingTime) seconds"
    }
    @IBAction func speakerButtonTapped(_ sender: Any) {
        
    }
    
//    private func setupAudioSession() {
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//           try audioSession.setCategory(.playAndRecord, mode: .default)
//           try audioSession.setActive(true)
//        } catch {
//           showAlert(message: "Failed to set up audio session: \(error.localizedDescription)")
//        }
//    }
//
//    private func configureAudioRecorder() {
//        let audioFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(audioFileName)
//
//        let settings: [String: Any] = [
//           AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//           AVSampleRateKey: 44100.0,
//           AVNumberOfChannelsKey: 2,
//           AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//        ]
//
//        do {
//           audioRecorder = try AVAudioRecorder(url: audioFilePath, settings: settings)
//           audioRecorder?.delegate = self
//           audioRecorder?.prepareToRecord()
//        } catch {
//           showAlert(message: "Failed to initialize audio recorder: \(error.localizedDescription)")
//        }
//    }

    // MARK: - Timer Methods
//    private func startTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
//           self?.updateTimeLabel()
//           self?.updateSliderPosition()
//        }
//    }

//    private func stopTimer() {
//        timer?.invalidate()
//        timer = nil
//    }

//    private func updateTimeLabel() {
//        let currentTime = isRecording ? audioRecorder?.currentTime ?? 0 : audioPlayer?.currentTime ?? 0
//        let minutes = Int(currentTime) / 60
//        let seconds = Int(currentTime) % 60
//        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
//        }
//
//        private func updateSliderPosition() {
//        if let player = audioPlayer {
//           recordingSlider.value = Float(player.currentTime / player.duration)
//        }
//    }
    
    // MARK: - Performance Metrics
       
   private func updatePerformanceMetrics() {
       // Generate random values between 70 and 100
       let clarityScore = Double.random(in: 70...100)
       let paceScore = Double.random(in: 70...100)
       let toneScore = Double.random(in: 70...100)
       let fluencyScore = Double.random(in: 70...100)
       
       // Update progress views (values must be between 0 and 1)
       clarityProgressBar.progress = Float(clarityScore / 100)
       paceProgressBar.progress = Float(paceScore / 100)
       toneProgressBar.progress = Float(toneScore / 100)
       fluencyProgressBar.progress = Float(fluencyScore / 100)
       
       // Update labels with percentage values
       clarityPercentLabel.text = "\(Int(clarityScore))%"
       pacePercentLabel.text = "\(Int(paceScore))%"
       tonePercentLabel.text = "\(Int(toneScore))%"
       fluencyPercentLabel.text = "\(Int(fluencyScore))%"
       
       // Generate and set feedback based on scores
       areaOfImprovementLabel.text = generateFeedback(
           clarity: clarityScore,
           pace: paceScore,
           tone: toneScore,
           fluency: fluencyScore
       )
   }
   
   private func generateFeedback(clarity: Double, pace: Double, tone: Double, fluency: Double) -> String {
       var feedback = ""
       
       // Add specific feedback based on the lowest scores
       let metrics = [
           (score: clarity, name: "clarity", advice: "Try to articulate words more clearly and avoid mumbling. Focus on proper pronunciation."),
           (score: pace, name: "pace", advice: "Work on maintaining a steady speaking rhythm. Avoid rushing through important points."),
           (score: tone, name: "tone", advice: "Practice varying your pitch and emphasis to make your speech more engaging."),
           (score: fluency, name: "fluency", advice: "Reduce filler words and practice smooth transitions between sentences.")
       ]
       
       // Sort metrics by score (ascending) and take the lowest 2
       let lowestMetrics = metrics.sorted { $0.score < $1.score }.prefix(2)
       
       for (index, metric) in lowestMetrics.enumerated() {
           feedback += "\(index + 1). \(metric.advice)\n"
       }
       
       // Add a positive note at the end
       feedback += "\nOverall, your speech shows good potential. Keep practicing these areas for even better results!"
       
       return feedback
   }

        
    func roundEdgesOfViews() {
        curveContainerEdges.forEach { view in
            view.layer.cornerRadius = 10         // Adjust the corner radius as needed
            view.clipsToBounds = true            // Ensures subviews respect the rounded corners
            view.layer.borderWidth = 0.2
            view.layer.borderColor = UIColor.black.cgColor
        }
        bookSymbol.layer.cornerRadius = 2
    }


    func startWaveAnimation() {
        for (index, wave) in waves.enumerated() {
            let delay = Double(index) * 0.1
            
            // Set corner radius to make the border rounded
            wave.layer.cornerRadius =  2
            wave.clipsToBounds = true
            
            animateBar(wave, delay: delay)
        }
    }

    func animateBar(_ wave: UIView, delay: Double) {
        UIView.animate(withDuration: 0.5,
                       delay: delay,
                       options: [.repeat, .autoreverse],
                       animations: {
            let randomScale = CGFloat.random(in: 0.5...1.5)
            wave.transform = CGAffineTransform(scaleX: 1.0, y: randomScale) // Only scale vertically
        }, completion: nil)
    }

    @IBAction func playButton(_ sender: Any) {
        if !isRecording {
            startRecording()
        }
    }

    @IBAction func pauseButton(_ sender: Any) {
        if isRecording {
            stopRecording()
        }
    }

    // MARK: - Helper Methods
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func startRecording() {
//        guard let audioRecorder = audioRecorder else {
//            showAlert(message: "Audio recorder not initialized")
//            return }
//
//        audioRecorder.record()
        isRecording = true


        playButton.isHidden = true
        pauseButton.isHidden = false
        waveRecordingView.isHidden = false
        readyView.isHidden = true
        recordingView.isHidden = true
        analyzingYourSpeech.isHidden = true
        areasOfImprovementView.isHidden = true
        feedbackView1.isHidden = true
        feedbackView2.isHidden = true
        speechToTextView.isHidden = true
        startWaveAnimation()


//        startTimer()
    }

    private func stopRecording() {
//        guard let recorder = audioRecorder else { return }

//        recorder.stop()
        isRecording = false
//        stopTimer()
        // Second transition: After delay, show analysis results
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            
     
            // Hide analyzing state
            analyzingYourSpeech.isHidden = true
            
            // Show analysis results
            areasOfImprovementView.isHidden = false
            feedbackView1.isHidden = false
            feedbackView2.isHidden = false
            speechToTextView.isHidden = false
            playButton.isHidden = false
            
            self.updatePerformanceMetrics()
            // Setup audio player for playback
//            self.setupAudioPlayer()
//            self.recordingSlider.isEnabled = true
        }


        pauseButton.isHidden = true
        playButton.isHidden = true
        waveRecordingView.isHidden = true
        analyzingYourSpeech.isHidden = false
        recordingView.isHidden = false


    }

//    private func setupAudioPlayer() {
//        let audioFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(audioFileName)
//        
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: audioFilePath)
//            audioPlayer?.delegate = self
//            audioPlayer?.prepareToPlay()
//        } catch {
//            showAlert(message: "Failed to load audio file: \(error.localizedDescription)")
//        }
//    }
//
//    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        recordingSlider.value = 0
//        updateTimeLabel()
//    }

}
