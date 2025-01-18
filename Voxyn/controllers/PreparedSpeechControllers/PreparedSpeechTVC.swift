//
//  PreparedSpeechTVC.swift
//  Voxyn
//
//  Created by Kanishq Mehta on 16/01/25.
//

import UIKit

class PreparedSpeechTVC: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    // This array will hold the filtered data for search results
    var filteredSpeechPractices: [SpeechPractice] = []
    var isSearching: Bool = false // Flag to check if searching is active
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.reloadData() // Reload the table with the updated data

         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return SpeechPracticeDataModel.shared.getAllSpeechPractices().count
        return isSearching ? filteredSpeechPractices.count : SpeechPracticeDataModel.shared.getAllSpeechPractices().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "preparedSpeech", for: indexPath)

//        var content = cell.defaultContentConfiguration()
        let speechPractices = SpeechPracticeDataModel.shared.getAllSpeechPractices()
        cell.textLabel?.text = speechPractices[indexPath.row].title
        cell.detailTextLabel?.text = speechPractices[indexPath.row].description
//        cell.contentConfiguration = content
        cell.showsReorderControl = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let dataModel = SpeechPracticeDataModel.shared
        var practices = dataModel.getAllSpeechPractices()
        let movedPractice = practices[sourceIndexPath.row]
        practices.remove(at: sourceIndexPath.row)
        practices.insert(movedPractice, at: destinationIndexPath.row)
        dataModel.updateSpeechPractices(with: practices)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SpeechPracticeDataModel.shared.deleteSpeechPractice(by: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
        }
    }
    
    @IBAction func unwindToPreparedSpeechTVC(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? AddPreparedSpeechTVC {
            // Validate input fields
            guard let title = sourceVC.titleTextField.text, !title.isEmpty,
                  let description = sourceVC.descTextField.text, !description.isEmpty,
                  let speechText = sourceVC.speechTextField.text, !speechText.isEmpty else {
                print("All fields are required.")
                return
            }

            // Create a new SpeechPractice object
            let newSpeechPractice = SpeechPractice(
                inputMode: .typed, // Assume user types the input for now
                title: title,
                description: description,
                originalText: speechText,
                userRecording: nil,
                createdAt: Date().description // Current date as string
            )

            // Add the new speech practice to the data model
            SpeechPracticeDataModel.shared.addSpeechPractice(newSpeechPractice)

            // Reload the table view to display the new entry
            tableView.reloadData()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
        } else {
            isSearching = true
            let allPractices = SpeechPracticeDataModel.shared.getAllSpeechPractices()
            filteredSpeechPractices = allPractices.filter { practice in
                practice.title.lowercased().contains(searchText.lowercased()) ||
                practice.description.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
