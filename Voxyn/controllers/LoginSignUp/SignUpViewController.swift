//
//  signUpViewController.swift
//  Voxyn
//
//  Created by Rakshit  on 21/01/25.
//

import UIKit

class SignUpViewController: UIViewController {

    let userDataModel = UserDataModel.shared
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let firstName = nameTextField.text, !firstName.isEmpty,
                     let email = emailTextField.text, !email.isEmpty,
                     let password = passwordTextField.text, !password.isEmpty else {
                   showAlert(message: "Please fill in all fields.")
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



