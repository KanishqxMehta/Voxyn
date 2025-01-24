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

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
                     let password = passwordTextField.text, !password.isEmpty else {
                   showAlert(message: "Please enter both email and password.")
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
