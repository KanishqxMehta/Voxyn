//
//  RecordingTableViewController.swift
//  Voxyn
//
//  Created by Kanishq Mehta on 19/01/25.
//

import UIKit

class RecordingTableViewController: UITableViewController {
    // MARK: - Properties
    let recordingDataModel = RecordingDataModel.shared
    var recordings: [Recording] = []

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup table view
        setupTableView()

        // Load data
        loadData()
    }

    // MARK: - Setup Methods
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RecordingCell")
    }

    private func loadData() {
        // Fetch all recordings
        if let currentUserId = UserDataModel.shared.getUser()?.userId {
            recordings = recordingDataModel.findRecordings(by: currentUserId)
        } else {
            recordings = []
        }
        tableView.reloadData()
    }

    // MARK: - TableView Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordingCell", for: indexPath)
        

        let recording = RecordingDataModel.shared.getRecording(by:indexPath.row + 1)
        
        if let recording {
            cell.textLabel?.text = recording.title
            cell.detailTextLabel?.text = DateFormatter.localizedString(from: recording.timestamp, dateStyle: .long, timeStyle: .none)
        }
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Fetch the selected recording
        let recording = RecordingDataModel.shared.getRecording(by: indexPath.row + 1)
        
        // Check if the recording exists
        guard let selectedRecording = recording else {
            print("Recording not found for row \(indexPath.row)")
            return
        }
        
        let storyboard = UIStoryboard(name: "SpeakingTasks", bundle: nil)
                if let practiceVC = storyboard.instantiateViewController(withIdentifier: "SpeakingTasks") as? PracticeViewController {
                    
                    // Configure practice view controller with the speech practice data
                    practiceVC.dataType = .readAloud  // or create a new case for prepared speech if needed
                    practiceVC.selectedData = selectedRecording   // Pass the SpeechPractice object directly
                    
                    navigationController?.pushViewController(practiceVC, animated: true)
                } else {
                    print("Failed to instantiate SpeakingTasks. Check its storyboard ID.")
                }

//         Instantiate the RecordingViewController
//        let storyboard = UIStoryboard(name: "Profile", bundle: nil) // Replace "Main" with your stofryboard name
//        if let recordingVC = self.storyboard?.instantiateViewController(withIdentifier: "recordings") as? RecordingViewController {
//            
//            // Pass the recording data
//            recordingVC.selectedData = selectedRecording
//            
//            // Set the data type based on the sessionType
//            switch selectedRecording.sessionType {
//            case .readAloud:
//                recordingVC.dataType = .readAloud
//            case .randomTopic:
//                recordingVC.dataType = .randomTopic
//            case .preparedSpeech:
//                recordingVC.dataType = .preparedSpeech
//            }
//
//            // Push the RecordingViewController
//            navigationController?.pushViewController(recordingVC, animated: true)
//        } else {
//            print("Failed to instantiate RecordingViewController. Check its storyboard ID.")
//        }
    }
}
