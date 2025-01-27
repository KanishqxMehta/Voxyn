//
//  nameChangeTableViewController.swift
//  Voxyn
//
//  Created by Kanishq Mehta on 19/01/25.
//

import UIKit

// MARK: - Protocol for Profile Updates
protocol ProfileUpdateDelegate: AnyObject {
    func didUpdateProfile()
}

class UpdateNameTableViewController: UITableViewController {
    
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    weak var delegate: ProfileUpdateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Name Details"
        
        // Configure text fields
        [firstNameTextField, lastNameTextField].forEach { textField in
            textField?.borderStyle = .none
            textField?.isEnabled = false // Initially disabled
//            textField?.autocapitalizationType = .words
//            textField?.autocorrectionType = .no
        }
        
        // Load current user's name
        if let user = UserDataModel.shared.getUser() {
            firstNameTextField.text = user.firstName
            lastNameTextField.text = user.lastName
        }
        
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
        // Update text fields
        
        [firstNameTextField, lastNameTextField].forEach { textField in
            textField?.isEnabled = isEditingName
            textField?.borderStyle = isEditingName ? .roundedRect : .none
//            textField?.isUserInteractionEnabled = isEditingName
//            textField?.backgroundColor = .clear
        }
        
        if isEditingName {
            firstNameTextField.becomeFirstResponder()
        }
        
    }
    
    
    @IBAction func isEditingBtn(_ sender: UIBarButtonItem) {
        if isEditingName {
            saveChanges()
        }
        isEditingName.toggle()
    }
    
    
    private func saveChanges() {
        guard let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !firstName.isEmpty else {
            showAlert(message: "First name cannot be empty")
            return
        }
        
        // Update user details in the shared model
        let updateSuccessful = UserDataModel.shared.updateUserDetails(
            newFirstName: firstName,
            newLastName: lastName,
            newDob: nil,
            newEmail: nil
        )
        
        if updateSuccessful {
            delegate?.didUpdateProfile() // Notify delegate about changes
            showSuccessAlert()
        } else {
            showAlert(message: "Failed to update name")
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showSuccessAlert() {
        let alert = UIAlertController(
            title: "Success",
            message: "Name updated successfully",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
