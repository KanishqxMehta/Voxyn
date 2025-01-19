//
//  ProfileTableViewController.swift
//  tempProj
//
//  Created by Kanishq Mehta on 18/01/25.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch the user from UserDataModel
        if let user = UserDataModel.shared.getUser() {
            // Combine the first and last name to display
            nameLabel.text = "\(user.firstName) \(user.lastName)"
        } else {
            // Handle the case where no user exists
            nameLabel.text = "Guest"
        }
    }
}


