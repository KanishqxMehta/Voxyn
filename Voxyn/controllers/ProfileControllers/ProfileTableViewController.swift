import UIKit

class ProfileTableViewController: UITableViewController {
    let dobLabelIndexPath = IndexPath(row: 2, section: 0)
    let dobDatePickerIndexPath = IndexPath(row: 3, section: 0)
    
    var dobDatePickerIsVisible: Bool = false {
        didSet {
            dobDatePicker.isHidden = !dobDatePickerIsVisible
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch the user from UserDataModel
        if let user = UserDataModel.shared.getUser() {
            // Combine the first and last name to display
            nameLabel.text = "\(user.firstName) \(user.lastName)"
            // Set the initial value for the date picker and label
            dobDatePicker.date = user.dob
            updateDoBLabel(with: user.dob)
        } else {
            // Handle the case where no user exists
            nameLabel.text = "Guest"
            dobLabel.text = "N/A"
        }
        
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
            
            // Animate the updates to the table view
            tableView.beginUpdates()
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
    
    /// Updates the date of birth label with the formatted date
    private func updateDoBLabel(with date: Date) {
        dobLabel.text = date.formatted(date: .abbreviated, time: .omitted)
    }
    
    /// Updates the user's date of birth in UserDataModel
    private func updateUserDob(with date: Date) {
        if UserDataModel.shared.updateUserDetails(newFirstName: nil, newLastName: nil, newDob: date, newEmail: nil) {
            print("Date of birth updated successfully.")
        } else {
            print("Failed to update date of birth.")
        }
    }
}
