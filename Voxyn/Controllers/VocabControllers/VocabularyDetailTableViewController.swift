//
//  VocabularyDetailTableViewController.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 24/12/24.
//

import UIKit
import AVFoundation

class VocabularyDetailTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var pronunciationLabel: UILabel!
    @IBOutlet var definitionLabel: UILabel!
    @IBOutlet var toggleExamplesLabel: UILabel!
    @IBOutlet var partOfSpeechLabel: UILabel!
    @IBOutlet var etymologyLabel: UILabel!
    @IBOutlet var exampleLabels: [UILabel]!
    @IBOutlet var practiceTextField: UITextField!
    @IBOutlet var tagButtons: [UIButton]!
    @IBOutlet var synonymslabel: UILabel!
    @IBOutlet var antonymsLabel: UILabel!
    
    var selectedWordId: Int?
    let speechSynthesizer = AVSpeechSynthesizer() // synthesizer
    
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
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        navigationItem.largeTitleDisplayMode = .never
        title = "Word Details"
        updateContent()
        
        // Add gesture recognizer for tap outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
    }
    
    func updateContent() {
        guard let wordId = selectedWordId,
            let vocabularyWord = VocabularyDataModel.shared.getVocabulary(by: wordId) else { return }
        
        wordLabel.text = vocabularyWord.word
        pronunciationLabel.text = vocabularyWord.pronunciationText
        definitionLabel.text = vocabularyWord.definition
        definitionLabel.numberOfLines = 0
        definitionLabel.lineBreakMode = .byWordWrapping
        
        partOfSpeechLabel.text = vocabularyWord.partOfSpeech
        etymologyLabel.text = vocabularyWord.etymology
                
        synonymslabel.text = vocabularyWord.synonyms.joined(separator: "  ")
        antonymsLabel.text = vocabularyWord.antonyms.joined(separator: "  ")

        zip(exampleLabels, vocabularyWord.exampleSentence).forEach { label, example in
            label.text = "• \(example)"
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
        }
        

        zip(tagButtons, vocabularyWord.tags).forEach { button, tag in
            button.setTitle("\(tag)", for: .normal)
            button.isHidden = false
        }

        if vocabularyWord.tags.count < tagButtons.count {
            for button in tagButtons[vocabularyWord.tags.count...] {
                button.isHidden = true
            }
        }

    }
    
    @IBAction private func checkButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func speakerButtonTapped(_ sender: UIButton) {
        speakWord()
    }
    
    private func speakWord() {
        guard let word = wordLabel.text, !word.isEmpty else { return }
        
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        speechSynthesizer.speak(utterance)
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case examplesCellIndexPath:
            return isExamplesVisible ? UITableView.automaticDimension : 0
        default:
            return UITableView.automaticDimension
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
    
    @IBAction func checkSentenceButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showVocabFeedback", sender: VocabularyDataModel.shared.getVocabulary(by: selectedWordId!))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVocabFeedback" {
            if let destinationVC = segue.destination as? VocabularyResultsViewController {
                if let sender = sender as? Vocabulary {
                    destinationVC.title = sender.word
                }
            }
        }
    }
}
