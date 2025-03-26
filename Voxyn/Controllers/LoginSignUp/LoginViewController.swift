//
//  LoginViewController.swift
//  Voxyn
//
//  Created by Rakshit  on 21/01/25.
//

import UIKit

class LoginViewController: UIViewController {

    let userDataModel = UserDataModel.shared
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
    

    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
                     let password = passwordTextField.text, !password.isEmpty else {
                   showAlert(message: "Please enter both email and password.")
                   return
               }
        if !isValidEmail(email) {
            showAlert(message: "Please enter a valid email address.")
            return
        }
               
               // Attempt to login with the provided credentials
        if userDataModel.login(email: email, password: password) {
                   // If login is successful, you can navigate to another screen or display a success message
                   print("Login successful! Welcome, \(5)")
//                   showAlert(message: "Login successful! Welcome, \(user.firstName)")
                   
                   // Navigate to another screen after successful login (e.g., Home screen)
                   performSegue(withIdentifier: "showHome", sender: self)
               } else {
                   // Show error if login fails
                   showAlert(message: "Invalid email or password.")
               }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
