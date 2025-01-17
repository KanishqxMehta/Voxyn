//
//  VocabularyDetailTableViewController.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 24/12/24.
//

import UIKit

class VocabularyDetailTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var pronunciationLabel: UILabel!
    @IBOutlet var definitionLabel: UILabel!
    @IBOutlet var toggleExamplesLabel: UILabel!
    
    @IBOutlet var exampleLabels: [UILabel]!
    @IBOutlet var practiceTextField: UITextField!
        
    var selectedWord: VocabularyWord?
    
    // MARK: - Cell IndexPaths
    let examplesCellIndexPath = IndexPath(row: 3, section: 0)
    
    // MARK: - State
    var isExamplesVisible: Bool = false {
        didSet {
            // Update the button title when visibility changes
            let exampleTitle = isExamplesVisible ? "Hide" : "Show"
            toggleExamplesLabel.text = exampleTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        navigationItem.largeTitleDisplayMode = .never
        title = "Word Details"
        updateContent()
        
        // Add gesture recognizer for tap outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
    }
    
    func updateContent() {
        guard let selectedWord = selectedWord else { return }
        
        wordLabel.text = selectedWord.word
        pronunciationLabel.text = selectedWord.pronunciation
        definitionLabel.text = selectedWord.definition
        definitionLabel.numberOfLines = 0
        definitionLabel.lineBreakMode = .byWordWrapping
        
        // Update examples
        zip(exampleLabels, selectedWord.examples).forEach { label, example in
            label.text = "• \(example)"
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
        }
    }
    
    @IBAction private func checkButtonTapped(_ sender: UIButton) {
        
    }
    
    func toggleExamplesVisibility() {
        isExamplesVisible.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            toggleExamplesVisibility()
        }
        tableView.deselectRow(at: indexPath, animated: true) // Remove 
    }

    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 120  // Word header
        case 1: return 120   // Definition
        case 2: return 44  // Examples
        case 3: return isExamplesVisible ? UITableView.automaticDimension : 0  // Examples (expanded or collapsed)
        case 4: return UITableView.automaticDimension  // Practice
        default: return UITableView.automaticDimension

        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }

}
