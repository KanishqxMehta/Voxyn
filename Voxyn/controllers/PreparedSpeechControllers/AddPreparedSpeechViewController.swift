//
//  AddPreparedSpeechViewController.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 19/01/25.
//

import UIKit

class AddPreparedSpeechViewController: UIViewController {
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet var speechTextView: UITextView!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add a cancel button to the navigation bar
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
    
        self.navigationItem.leftBarButtonItem = cancelButton
        
        applyBorderAndCornerRadius()
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
    
    // MARK: - Actions for text fields and text view
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
//        checkFields()
    }

}
