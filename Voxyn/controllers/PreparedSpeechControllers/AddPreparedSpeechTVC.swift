//
//  AddPreparedSpeechTVC.swift
//  Voxyn
//
//  Created by Kanishq Mehta on 17/01/25.
//

import UIKit

class AddPreparedSpeechTVC: UITableViewController {
//    var speechData: SpeechPractice

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var speechTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)

        performSegue(withIdentifier: "saveUnwind", sender: self)
    }
}
