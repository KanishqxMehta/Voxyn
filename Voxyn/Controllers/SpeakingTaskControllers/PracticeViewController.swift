//
//  VocabularyViewController.swift
//  VocabularyScreen
//
//  Created by student-2 on 13/01/25.
//

import UIKit
import AVFoundation

class PracticeViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate  {
    
    var selectedPassageId: Int = 0
    
    // MARK: - Properties
    private var timer: Timer?
    private var isRecording = false
    private var isAudioPlaying = false

    @IBOutlet var contentView: UIView!
    @IBOutlet var curveContainerEdges: [UIView]!
    @IBOutlet var estimatedTimeView: UIView!
    
    @IBOutlet weak var playRecordingButton: UIButton!
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
    
    
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
   // var isRecording = false
    var audioFileName: URL?
    var audioFileDirectory: String = ""
    var audioFileTitle: String = ""
    
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
        setUpAudioSession()
        recordingSlider.setThumbImage(UIImage(named: "Ellipse 27"), for: .normal)
        print("Button is enabled:", playRecordingButton.isEnabled)

        if let data = selectedData as? Recording {
            configureRecordsData(selectedData)
            print("Button enabled after configureRecordsData:", playRecordingButton.isEnabled)
            
        } else {
            setupInitialState()
          
            print("Practice View Controller Loaded")
        }
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
    
    // Get session type based on current data type
        private func getSessionType() -> SessionType {
            switch dataType {
            case .readAloud:
                return .readAloud
            case .randomTopic:
                return .randomTopic
            case .preparedSpeech:
                return .preparedSpeech
            case .none:
                return .readAloud // Default fallback
            }
        }
    
    
    
    private func configureRecordsData(_ data: Any?) {
        roundEdgesOfViews()
        analyzingYourSpeech.isHidden = true

        areasOfImprovementView.isHidden = false
        feedbackView1.isHidden = false
        feedbackView2.isHidden = false
        speechToTextView.isHidden = false
        playButton.isHidden = true
        pauseButton.isHidden = true

        updatePerformanceMetrics()
        playRecordingButton.isEnabled = true
        waveRecordingView.isHidden = true
        readyView.isHidden = true
        
        guard let recording = data as? Recording else {
            print("Error: data is not a Recording object.")
            return
        }
        
        audioFileName = URL(fileURLWithPath: recording.title)

        // Extract sessionType and topicId
        let sessionType = recording.sessionType
        let topicId = recording.topicId
        if sessionType == .readAloud {
            if let sessionData = ReadAloudDataModel.shared.searchPassage(by: topicId) {
                passageTextView.text = sessionData.selectedPassage
                title = sessionData.title// Display in the UI
            } else {
                print("Passage not found for topicId: \(topicId)")
            }
        } else if sessionType == .randomTopic {
            if let sessionData = RandomTopicDataModel.shared.searchTopic(by: topicId) {
                passageTextView.text = sessionData.description
                title = sessionData.title
            }
        }

    }


    
    private func configureReadAloudContent(_ data: ReadAloud) {
        // Update UI for read aloud passage
        selectedPassageId = data.passageId
        title = data.title // Set navigation title
        passageTextView.text = data.selectedPassage
        speakingTimeLabel.text = "Estimated Speaking Time:"
        speechToTextLabel.text = data.selectedPassage
        estimatedSpeakingTimeLabel.text = "\(data.estimatedSpeakingTime) seconds"

    }
    
    private func configureRandomTopicContent(_ topic: RandomTopic) {
        // Update UI for random topic
        selectedPassageId = topic.topicId
        title = topic.title // Set navigation title
        passageTextView.text = topic.description
        speakingTimeLabel.text = "Minimum Speaking Time"
        speechToTextLabel.text = topic.description
        estimatedSpeakingTimeLabel.text = "\(topic.minimumSpeakingTime) seconds"
    }

    private func configurePreparedSpeechContent(_ speech: SpeechPractice) {
        // Update UI for random topic
        selectedPassageId = speech.id
        title = speech.title // Set navigation title
        passageTextView.text = speech.originalText
        speakingTimeLabel.text = "Minimum Speaking Time"
        speechToTextLabel.text = speech.originalText
        estimatedSpeakingTimeLabel.text = "\(50) seconds"
//        estimatedSpeakingTimeLabel.text = "\(topic.minimumSpeakingTime) seconds"
    }
    @IBAction func speakerButtonTapped(_ sender: Any) {
        
    }
    


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
    
    
    
    
    func setUpAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    // Set up the audio recorder to save the recording as a .m4a file
    func setUpAudioRecorder() {

        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        audioFileDirectory = documentsDirectory.path
        // Generate a unique filename using timestamp
        let timestamp = Int(Date().timeIntervalSince1970)
        audioFileName = documentsDirectory.appendingPathComponent("audioRecording_\(timestamp).m4a")
        audioFileTitle = audioFileName!.path
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName!, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.prepareToRecord()
        } catch {
            print("Failed to set up recorder: \(error)")
        }
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
        setUpAudioRecorder()
        
        // Start recording
        audioRecorder?.record()
        
        
        isRecording = true
        playButton.isHidden = true
        readyView.isHidden = true
        recordingView.isHidden = true
        analyzingYourSpeech.isHidden = true
        areasOfImprovementView.isHidden = true
        feedbackView1.isHidden = true
        feedbackView2.isHidden = true
        speechToTextView.isHidden = true
        
        pauseButton.isHidden = false
        waveRecordingView.isHidden = false
        startWaveAnimation()

//        startTimer()
    }

    private func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        let userIdFromDefault = UserDefaults.standard.integer(forKey: "userId")
        saveNewRecording(userId: userIdFromDefault, title: audioFileTitle, audioFileURL: audioFileDirectory, sessionType: getSessionType(), topicId: selectedPassageId )
        updateUIAfterRecordingStop()

           // Delay analysis results display
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.showAnalysisResults()
        }
    }
    
    private func updateUIAfterRecordingStop() {
        pauseButton.isHidden = true
        playButton.isHidden = true
        waveRecordingView.isHidden = true
        analyzingYourSpeech.isHidden = false
        recordingView.isHidden = false
    }

    private func showAnalysisResults() {
        analyzingYourSpeech.isHidden = true

        areasOfImprovementView.isHidden = false
        feedbackView1.isHidden = false
        feedbackView2.isHidden = false
        speechToTextView.isHidden = false
        playButton.isHidden = false

        updatePerformanceMetrics()
        playRecordingButton.isEnabled = true
    }
    
    func saveNewRecording(userId: Int, title: String, audioFileURL: String, sessionType: SessionType, topicId: Int) {
        
        print("Saving new recording...")
            print("User ID: \(userId)")
            print("Title: \(title)")
            print("Audio File URL: \(audioFileURL)")
            print("Session Type: \(sessionType)")
        
        let newRecording = Recording(
            recordingId: (RecordingDataModel.shared.getAllRecordings().last?.recordingId ?? 0) + 1, // Auto-increment ID
            userId: userId,
            title: title,
            audioFileURL: audioFileURL,
            timestamp: Date(),
            sessionType: sessionType,
            topicId: topicId
        )
        
        RecordingDataModel.shared.saveRecording(newRecording)
        StreakDataModel.shared.updateStreakIfValid(userId: userId)
        SessionDataModel.shared.updateSessionCount(for: userId)
        
    }
    
    // in this audio play back only first recording is gettig played back
    // if done multiple recording on the same screen only first one will be played back
//    
//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, to outputFileURL: URL, successfully flag: Bool) {
//        if flag {
//            print("Recording successfully finished!")
//            // Optionally, you can show a message to the user or perform additional actions
//        } else {
//            print("Recording failed.")
//        }
//    }
    @IBAction func playRecordingButtonTapped(_ sender: Any) {
        guard let audioFileName = audioFileName else {
               print("No audio file to play.")
               return
           }
        print("audioFileName == \(audioFileName)")

           if isAudioPlaying {
               // Pause the audio if it is currently playing
               audioPlayer?.pause()
               isAudioPlaying = false
               playRecordingButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
           } else {
               // Resume or start playing
               do {
                   if audioPlayer == nil {
                       // Initialize the audio player if it doesn't exist yet
                       audioPlayer = try AVAudioPlayer(contentsOf: audioFileName)
                       audioPlayer?.delegate = self
                   }
                   audioPlayer?.play()
                   isAudioPlaying = true
                   playRecordingButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
               } catch {
                   print("Error playing audio: \(error)")
               }
           }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("Audio playback finished successfully.")
            isAudioPlaying = false
            playRecordingButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            print("Audio playback failed.")
        }
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
