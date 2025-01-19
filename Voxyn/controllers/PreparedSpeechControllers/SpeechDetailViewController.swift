import UIKit

class SpeechDetailViewController: UIViewController {

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
        guard isEditingSpeech, let speech = speechPractice else { return }

        // Validate non-empty fields
        guard let updatedTitle = titleTextView.text, !updatedTitle.isEmpty,
              let updatedDescription = descriptionTextView.text, !updatedDescription.isEmpty,
              let updatedText = speechTextView.text, !updatedText.isEmpty else {
            showAlert(message: "All fields must be filled.")
            return
        }

        // Update the speechPractice object
        let updatedSpeech = SpeechPractice(
            id: speech.id,
            inputMode: speech.inputMode,
            title: updatedTitle,
            description: updatedDescription,
            originalText: updatedText,
            userRecording: speech.userRecording,
            createdAt: speech.createdAt
        )

        // Persist the updated speechPractice in the data model
        dataModel.updateSpeechPractice(updatedSpeech)

        // Update the local speechPractice property
        speechPractice = updatedSpeech
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
        speechTextView?.backgroundColor = .systemGray6  // Always systemGray6
        speechTextView?.layer.borderWidth = isEditingSpeech ? 0.2 : 0
        speechTextView?.clipsToBounds = true

        practiceStackView.isHidden = isEditingSpeech // Hide stack view when editing

        if !isEditingSpeech {
            saveChanges()
        }
    }

    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        isEditingSpeech.toggle()
    }
}
