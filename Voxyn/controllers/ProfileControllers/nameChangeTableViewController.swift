//
//  nameChangeTableViewController.swift
//  Voxyn
//
//  Created by Kanishq Mehta on 19/01/25.
//

import UIKit

class nameChangeTableViewController: UITableViewController {
    
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Name Details"
        updateEditingState()
    }
    
    var isEditingName: Bool = false {
        didSet {
            updateEditingState()
        }
    }
    
    private func updateEditingState() {
        editBarButton.title = isEditingName ? "Save" : "Edit"
        navigationItem.title = isEditingName ? "Edit Name" : "Name Details"
        
        // Update text views
        //        [titleTextView, descriptionTextView].forEach { textView in
        //            textView?.isEditable = isEditingSpeech
        //            textView?.backgroundColor = isEditingSpeech ? .systemGray6 : .clear
        //            textView?.layer.borderWidth = isEditingSpeech ? 0.2 : 0
        //            textView?.clipsToBounds = true
        //        }
        
    }
    @IBAction func isEditingBtn(_ sender: UIBarButtonItem) {
        isEditingName.toggle()
    }
}
