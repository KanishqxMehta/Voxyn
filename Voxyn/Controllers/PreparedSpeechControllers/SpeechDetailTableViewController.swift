//
//  SpeechDetailTableViewController.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 18/01/25.
//

import UIKit

class SpeechDetailTableViewController: UITableViewController {

    @IBOutlet var editBarButton: UIBarButtonItem!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var speechTextView: UITextView!
    @IBOutlet weak var practiceCountLabel: UILabel!
    @IBOutlet weak var practiceButton: UIButton!
    
    
    // MARK: - Properties
    var speechPractice: SpeechPractice?
    private let dataModel = SpeechPracticeDataModel.shared
    
    var isEditingSpeech: Bool = false {
        didSet {
            updateEditingState()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextViews()
        loadSpeechData()
    }
    
    private func setupTextViews() {
        [titleTextView, descriptionTextView, speechTextView].forEach { textView in
            textView?.isEditable = false
            textView?.backgroundColor = .clear
        }
    }
    
    // MARK: - Data Management
    private func loadSpeechData() {
        guard let speech = speechPractice else { return }
        titleTextView.text = speech.title
        descriptionTextView.text = speech.description
        speechTextView.text = speech.originalText
        practiceCountLabel.text = "3" // Placeholder for future count management
    }
    
    private func saveChanges() {
        guard isEditingSpeech, let speech = speechPractice else { return }

        // Validate non-empty fields
        guard let updatedTitle = titleTextView.text, !updatedTitle.isEmpty,
              let updatedDescription = descriptionTextView.text, !updatedDescription.isEmpty,
              let updatedText = speechTextView.text, !updatedText.isEmpty else {
            showAlert(message: "All fields must be filled.")
            return
        }

        let updatedSpeech = SpeechPractice(
            id: speech.id,
            inputMode: speech.inputMode,
            title: updatedTitle,
            description: updatedDescription,
            originalText: updatedText,
            userRecording: speech.userRecording,
            createdAt: speech.createdAt
        )

        dataModel.updateSpeechPractice(updatedSpeech)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

    private func updateEditingState() {
        editBarButton.title = isEditingSpeech ? "Save" : "Edit"
        navigationItem.title = isEditingSpeech ? "Edit Speech" : "Speech Details"

        [titleTextView, descriptionTextView, speechTextView].forEach { textView in
            textView?.isEditable = isEditingSpeech
            textView?.backgroundColor = isEditingSpeech ? .systemGray6 : .clear
        }

        UIView.animate(withDuration: 0.3) {
            self.practiceButton.alpha = self.isEditingSpeech ? 0 : 1
            self.practiceCountLabel.alpha = self.isEditingSpeech ? 0 : 1
        }

        if !isEditingSpeech {
            saveChanges()
        }

        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isEditingSpeech {
            // Hide rows in sections 1 and 2 when editing
            if indexPath.section == 1 || indexPath.section == 2 {
                return 0
            }
        }
        return UITableView.automaticDimension
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        // When entering edit mode, just toggle
        if !isEditingSpeech {
            isEditingSpeech = true
            return
        }
        
        // When exiting edit mode, validate fields
        guard let title = titleTextView.text, !title.isEmpty,
              let description = descriptionTextView.text, !description.isEmpty,
              let text = speechTextView.text, !text.isEmpty else {
            showAlert(message: "All fields must be filled.")
            return
        }
        
        // If all fields are valid, toggle off editing state
        isEditingSpeech = false
    }
    
}
