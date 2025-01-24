//
//  signUpViewController.swift
//  Voxyn
//
//  Created by Rakshit  on 21/01/25.
//

import UIKit

class SignUpViewController: UIViewController {

    let userDataModel = UserDataModel.shared
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Add gesture to dismiss keyboard when tapping outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        // Do any additional setup after loading the view.
    }
    
 
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            self.view.frame.origin.y = -keyboardHeight / 2  // Adjust this value as needed
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0  // Reset the view back
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let firstName = nameTextField.text, !firstName.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        
        // Check if the email is in valid format
            if !isValidEmail(email) {
                showAlert(message: "Please enter a valid email address.")
                return
            }
        
        if password.count < 6 {
            showAlert(message: "Password must be at least 6 characters long.")
            return
        }


            // Ensure password and confirm password match
            guard password == confirmPassword else {
                showAlert(message: "Passwords do not match.")
                return
            }
        
        let constantDob = Calendar.current.date(from: DateComponents(year: 2004, month: 4, day: 6)) ?? Date()

        
        let signUpSuccess = userDataModel.signUp(firstName: firstName,lastName: " ",email: email,dob: constantDob ,password: password)
                
            // Handle sign-up result
            if signUpSuccess {
                
                print("Sign up done")
//                    showAlert(message: "Sign-up successful!")
                // Optionally, navigate to another screen after successful sign-up
                 performSegue(withIdentifier: "showLogin", sender: self)
            } else {
                    showAlert(message: "Sign-up failed. Please try again.")
                
            }
        }
    
    // MARK: - Helper Method for Alerts
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}



