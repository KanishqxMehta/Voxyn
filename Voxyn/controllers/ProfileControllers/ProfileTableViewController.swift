import UIKit

class ProfileTableViewController: UITableViewController, ProfileUpdateDelegate {
    
    
    let dobLabelIndexPath = IndexPath(row: 2, section: 0)
    let dobDatePickerIndexPath = IndexPath(row: 3, section: 0)
    
    var dobDatePickerIsVisible: Bool = false {
        didSet {
            dobDatePicker.isHidden = !dobDatePickerIsVisible
        }
    }
    
    func didUpdateProfile() {
        if let user = UserDataModel.shared.getUser() {
            nameLabel.text = "\(user.firstName) \(user.lastName)"
            dobDatePicker.date = user.dob
            updateDoBLabel(with: user.dob) // Ensure DoB label is updated
        } else {
            nameLabel.text = "Guest"
            dobLabel.text = "N/A"
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        didUpdateProfile()
        
        // Set the maximum date for the date picker
        dobDatePicker.maximumDate = Date()
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        // Update the label and save the new date in UserDataModel
        let selectedDate = sender.date
        updateDoBLabel(with: selectedDate)
        updateUserDob(with: selectedDate)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == dobLabelIndexPath {
            dobDatePickerIsVisible.toggle()
            
            // Reload the specific section
            tableView.beginUpdates()
            tableView.reloadRows(at: [dobDatePickerIndexPath], with: .fade)
            tableView.endUpdates()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case dobDatePickerIndexPath where !dobDatePickerIsVisible:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case dobDatePickerIndexPath where !dobDatePickerIsVisible:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
    // Updates the date of birth label with the formatted date
    private func updateDoBLabel(with date: Date) {
        dobLabel.text = date.formatted(date: .abbreviated, time: .omitted)
    }
    
    // Updates the user's date of birth in UserDataModel
    private func updateUserDob(with date: Date) {
        if UserDataModel.shared.updateUserDetails(newFirstName: nil, newLastName: nil, newDob: date, newEmail: nil) {
            print("Date of birth updated successfully.")
        } else {
            print("Failed to update date of birth.")
        }
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        // Clear the user data from the data model
        UserDataModel.shared.clearUser()
        
        // Instantiate the sign-in view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
        let signInVC = storyboard.instantiateViewController(withIdentifier: "Main") // Replace with your sign-in VC identifier
        
        // Find the active window scene
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            // Set the sign-in view controller as the root
            window.rootViewController = signInVC
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditNameSegue",
           let nameChangeVC = segue.destination as? UpdateNameTableViewController {
            nameChangeVC.delegate = self // Set the delegate
        }
    }
}
