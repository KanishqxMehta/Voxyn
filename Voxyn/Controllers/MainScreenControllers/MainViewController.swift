//
//  MainViewController.swift
//  Voxyn
//
//  Created by Kanishq Mehta on 15/01/25.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController {

    @IBOutlet weak var sessionValueLabel: UILabel!
    @IBOutlet weak var streakValueLabel: UILabel!
    @IBOutlet var roundCornerViews: [UIView]!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet var startButton: [UIButton]!
    
    @IBOutlet weak var clarityProgressLabel: UILabel!
    @IBOutlet weak var toneProgressLabel: UILabel!
    @IBOutlet weak var paceProgressLabel: UILabel!
    @IBOutlet weak var fluencyProgressLabel: UILabel!
    
    @IBOutlet weak var clarityProgressBar: UIProgressView!
    @IBOutlet weak var toneProgressBar: UIProgressView!
    @IBOutlet weak var paceProgressBar: UIProgressView!
    @IBOutlet weak var fluencyProgressBar: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStreakAndSessions()
        
        for startButton in startButton {
            startButton.layer.shadowColor = UIColor.black.cgColor  // Shadow color
            startButton.layer.shadowOpacity = 0.3                 // Shadow opacity (0.0 to 1.0)
            startButton.layer.shadowOffset = CGSize(width: 0, height: 0) // Shadow offset
            startButton.layer.shadowRadius = 3                    // Shadow blur radius
            
            // Optional: To make the shadow visible when the button is rounded
            startButton.layer.masksToBounds = false
        }

        
        // Round corners for specific views
        roundCornerViews.forEach { view in
            view.layer.cornerRadius = 8  // Adjust this value to control the roundness
            view.clipsToBounds = true    // Ensures the content stays within rounded bounds
        }
        
        // Set the navigation title with the user's name
        self.navigationItem.title = "Hi, \(UserDataModel.shared.getUser()?.firstName ?? "Guest")"
        
        updateChart()
        updateProgress()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUserName()
        updateStreakAndSessions()
        
        updateChart()
        updateProgress()
    }

    private func updateUserName() {
        self.navigationItem.title = "Hi, \(UserDataModel.shared.getUser()?.firstName ?? "Guest")"
    }
    
    private func removePreviousChart() {
        for subview in chartView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func updateChart() {
        removePreviousChart()  // Clean existing charts
        
        // Get fresh recordings data for the current user
        var freshRecordings: [Recording] = []
        if let userId = UserDataModel.shared.getUser()?.userId {
            freshRecordings = RecordingDataModel.shared.findRecordings(by: userId)
            print("[Debug] Found \(freshRecordings.count) fresh recordings for user \(userId)")
        }
        
        // Create a new instance of ChartView with fresh recordings
        let chartViewInstance = ChartView(recordings: freshRecordings)
        
        // Create and configure the hosting controller
        let hostingController = UIHostingController(rootView: chartViewInstance)
        addChild(hostingController)
        chartView.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: chartView.topAnchor, constant: 10),
            hostingController.view.bottomAnchor.constraint(equalTo: chartView.bottomAnchor, constant: -10),
            hostingController.view.leadingAnchor.constraint(equalTo: chartView.leadingAnchor, constant: 10),
            hostingController.view.trailingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: -10),
        ])
        
        hostingController.didMove(toParent: self)
    }

    private func updateProgress() {
        guard let userId = UserDataModel.shared.getUser()?.userId else {
            print("No user ID found. Resetting progress.")
            resetProgressBars()
            return
        }
        let recordings = RecordingDataModel.shared.findRecordings(by: userId)
        
        guard !recordings.isEmpty else {
            print("No recordings found. Resetting progress.")
            resetProgressBars()
            return
        }
        
        let averageScores = RecordingDataModel.shared.calculateAverageScores(for: recordings)
        updateProgressBars(with: averageScores)
    }

    private func resetProgressBars() {
        clarityProgressBar.progress = 0
        toneProgressBar.progress = 0
        paceProgressBar.progress = 0
        fluencyProgressBar.progress = 0
        
        clarityProgressLabel.text = "0%"
        toneProgressLabel.text = "0%"
        paceProgressLabel.text = "0%"
        fluencyProgressLabel.text = "0%"
    }

    private func updateProgressBars(with averageScores: [FeedbackCategory: Double]) {
        let avgClarity = averageScores[.clarity] ?? 0
        let avgTone = averageScores[.tone] ?? 0
        let avgPace = averageScores[.pace] ?? 0
        let avgFluency = averageScores[.fluency] ?? 0
        
        clarityProgressBar.progress = Float(avgClarity / 100.0)
        toneProgressBar.progress = Float(avgTone / 100.0)
        paceProgressBar.progress = Float(avgPace / 100.0)
        fluencyProgressBar.progress = Float(avgFluency / 100.0)
        
        clarityProgressLabel.text = "\(Int(avgClarity))%"
        toneProgressLabel.text = "\(Int(avgTone))%"
        paceProgressLabel.text = "\(Int(avgPace))%"
        fluencyProgressLabel.text = "\(Int(avgFluency))%"
    }


    @IBAction func lessonsBtnClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Lessons", bundle: nil) // Replace "OtherStoryboardName" with the name of your storyboard file
        
        // Instantiate the view controller
        if let lessonsVC = storyboard.instantiateViewController(withIdentifier: "Lessons") as? LessonsTableViewController {
            // Navigate to the view controller
            self.navigationController?.pushViewController(lessonsVC, animated: true)
        } else {
            print("Failed to instantiate LessonsViewController. Check its storyboard ID.")
        }
    }
    
    
    @IBAction func vocabBtnClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Vocabulary", bundle: nil) // Replace "OtherStoryboardName" with the name of your storyboard file
        
        // Instantiate the view controller
        if let vocabVC = storyboard.instantiateViewController(withIdentifier: "Vocab") as? VocabularyTableViewController {
            // Navigate to the view controller
            self.navigationController?.pushViewController(vocabVC, animated: true)
        } else {
            print("Failed to instantiate LessonsViewController. Check its storyboard ID.")
        }

    }
    
    func updateStreakAndSessions(){
        let userId = UserDefaults.standard.integer(forKey: "userId")
        
        StreakDataModel.shared.checkAndResetStreak(userId: userId)
        
         let streak = StreakDataModel.shared.fetchStreakCount(userId: userId)
            streakValueLabel.text = ("\(streak)")
        
        let session = SessionDataModel.shared.fetchSessionCount(for: userId)
        sessionValueLabel.text = "\(session)"
        
    }
}
