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
//    private var audioRecorder: AVAudioRecorder?
//    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    private var isRecording = false
//    private let audioFileName = "recording.m4a"

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
        timerLabel.text = "00:00"

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
