import UIKit

protocol SpeechDetailDelegate: AnyObject {
    func speechDetailViewController(_ controller: SpeechDetailViewController, didUpdateSpeech speech: SpeechPractice)
}

class SpeechDetailViewController: UIViewController {
    weak var delegate: SpeechDetailDelegate?

    @IBOutlet var editBarButton: UIBarButtonItem!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var speechTextView: UITextView!
    @IBOutlet weak var practiceCountLabel: UILabel!
    @IBOutlet weak var practiceButton: UIButton!
    @IBOutlet var headings: [UILabel]!
    @IBOutlet var practiceStackView: UIStackView!

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
        navigationItem.title = "Speech Details"

        setupTextViews()
        loadSpeechData()
    }

    private func setupTextViews() {
        [titleTextView, descriptionTextView, speechTextView].forEach { textView in
            textView.layer.cornerRadius = 8
            textView.layer.borderColor = UIColor.gray.cgColor
        }
    }

    // MARK: - Data Management
    private func loadSpeechData() {
        guard let speech = speechPractice else { return }
        titleTextView.text = speech.title
        descriptionTextView.text = speech.description
        speechTextView.text = speech.originalText
        practiceCountLabel.text = "Practiced X times" // Placeholder for future count management
    }

    private func saveChanges() {
        // Remove the isEditingSpeech check since we want to save when exiting edit mode
        guard let speech = speechPractice else {
            print("No speech practice available")
            return
        }
        
        // Validate non-empty fields
        guard let updatedTitle = titleTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let updatedDescription = descriptionTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let updatedText = speechTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !updatedTitle.isEmpty,
              !updatedDescription.isEmpty,
              !updatedText.isEmpty else {
            showAlert(message: "All fields must be filled.")
            return
        }
        
        // Create updated speech practice
        let updatedSpeech = SpeechPractice(
            id: speech.id,
            inputMode: speech.inputMode,
            title: updatedTitle,
            description: updatedDescription,
            originalText: updatedText,
            userRecording: speech.userRecording,
            createdAt: speech.createdAt
        )
        
        // Update the data model
        dataModel.updateSpeechPractice(updatedSpeech)
        
        // Update the local speechPractice property
        speechPractice = updatedSpeech
        
        // Notify delegate of the update
        delegate?.speechDetailViewController(self, didUpdateSpeech: updatedSpeech)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

    private func updateEditingState() {
        editBarButton.title = isEditingSpeech ? "Save" : "Edit"
        navigationItem.title = isEditingSpeech ? "Edit Speech" : "Speech Details"
        navigationItem.hidesBackButton = isEditingSpeech
        
        // Update text views
        [titleTextView, descriptionTextView].forEach { textView in
            textView?.isEditable = isEditingSpeech
            textView?.backgroundColor = isEditingSpeech ? .systemGray6 : .clear
            textView?.layer.borderWidth = isEditingSpeech ? 0.2 : 0
            textView?.clipsToBounds = true
        }
        
        // Update speech text view separately
        speechTextView?.isEditable = isEditingSpeech
        speechTextView?.backgroundColor = .systemGray6
        speechTextView?.layer.borderWidth = isEditingSpeech ? 0.2 : 0
        speechTextView?.clipsToBounds = true
        
        practiceStackView.isHidden = isEditingSpeech
        
        // Only call saveChanges when exiting edit mode
        if !isEditingSpeech {
            saveChanges()
        }
    }
    
    @IBAction func practiceButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SpeakingTasks", bundle: nil)
        if let practiceVC = storyboard.instantiateViewController(withIdentifier: "SpeakingTasks") as? PracticeViewController {
            guard let speech = speechPractice else { return }
            
            // Configure practice view controller with the speech practice data
            practiceVC.dataType = .readAloud  // or create a new case for prepared speech if needed
            practiceVC.selectedData = speech   // Pass the SpeechPractice object directly
            
            navigationController?.pushViewController(practiceVC, animated: true)
        } else {
            print("Failed to instantiate SpeakingTasks. Check its storyboard ID.")
        }
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        isEditingSpeech.toggle()
    }
}
