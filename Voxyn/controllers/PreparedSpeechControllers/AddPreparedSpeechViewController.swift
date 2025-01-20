import UIKit

class AddPreparedSpeechViewController: UIViewController {
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet var speechTextView: UITextView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Speech"

        // Add a cancel button to the navigation bar
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        applyBorderAndCornerRadius()
        checkFields() // Initial validation to disable the save button if fields are empty

        // Add observers for text changes in UITextView
        [titleTextView, descTextView, speechTextView].forEach { textView in
            textView.delegate = self
        }
    }
    
    func applyBorderAndCornerRadius() {
        // Apply the corner radius and border to each UITextView in the array
        [titleTextView, descTextView, speechTextView].forEach { textView in
            textView.layer.cornerRadius = 10
            textView.layer.borderWidth = 0.2
            textView.layer.borderColor = UIColor.gray.cgColor
            textView.clipsToBounds = true
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        performSegue(withIdentifier: "saveUnwind", sender: self)
    }
    
    @objc func cancelButtonTapped() {
       dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Validation for fields
    func checkFields() {
        let isTitleEmpty = titleTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isDescEmpty = descTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isSpeechEmpty = speechTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        // Disable the save button if any of the fields are empty
        saveButton.isEnabled = !(isTitleEmpty || isDescEmpty || isSpeechEmpty)
    }
}

// MARK: - UITextViewDelegate
extension AddPreparedSpeechViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkFields() // Validate fields whenever the text changes
    }
}
