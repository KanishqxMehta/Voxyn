//
//  PreparedSpeechTVC.swift
//  Voxyn
//
//  Created by Kanishq Mehta on 16/01/25.
//

import UIKit

class PreparedSpeechTVC: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    private let preparedSpeechdataModel = SpeechPracticeDataModel.shared
    var filteredSpeechPractices: [SpeechPractice] = []
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.reloadData()

        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredSpeechPractices.count : preparedSpeechdataModel.getAllSpeechPractices().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "preparedSpeech", for: indexPath)

        let speechPractices = isSearching ? filteredSpeechPractices : preparedSpeechdataModel.getAllSpeechPractices()
        cell.textLabel?.text = speechPractices[indexPath.row].title
        cell.detailTextLabel?.text = speechPractices[indexPath.row].description

        cell.showsReorderControl = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var practices = preparedSpeechdataModel.getAllSpeechPractices()
        let movedPractice = practices.remove(at: sourceIndexPath.row)
        practices.insert(movedPractice, at: destinationIndexPath.row)

        // Update the model with the new order
        preparedSpeechdataModel.updateSpeechPractice(movedPractice)
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Handle delete for both normal and search states
//            if isSearching {
//                // Get the speech practice from filtered results
//                let practiceToDelete = filteredSpeechPractices[indexPath.row]
//                
//                // Find the index in the main data source
//                if let mainIndex = preparedSpeechdataModel.getAllSpeechPractices().firstIndex(where: { $0.id == practiceToDelete.id }) {
//                    // Delete from data model
//                    let deleted = preparedSpeechdataModel.deleteSpeechPractice(by: mainIndex)
//                    
//                    // Remove from filtered array
//                    filteredSpeechPractices.remove(at: indexPath.row)
//                    
//                    print(deleted!.id)
//                }
//            } else {
                // Delete directly from data model
                let deleted = preparedSpeechdataModel.deleteSpeechPractice(by: indexPath.row)
                print("else: \(deleted!.id)")

//            }
            
            // Delete row from table view with animation
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func unwindToPreparedSpeechTVC(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? AddPreparedSpeechViewController {
            // Validate input fields
            guard let title = sourceVC.titleTextView.text, !title.isEmpty,
                  let description = sourceVC.descTextView.text, !description.isEmpty,
                  let speechText = sourceVC.speechTextView.text, !speechText.isEmpty
            else {
                print("All fields are required.")
                return
            }

            // Create a new SpeechPractice object
            let newSpeechPractice = SpeechPractice(
                id: 0,
                inputMode: .typed, // Assume user types the input for now
                title: title,
                description: description,
                originalText: speechText,
                userRecording: nil,
                createdAt: Date().description // Current date as string
            )

            // Add the new speech practice to the data model
            preparedSpeechdataModel.addSpeechPractice(newSpeechPractice)

            // Reload the table view to display the new entry
            tableView.reloadData()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
        } else {
            isSearching = true
            let allPractices = preparedSpeechdataModel.getAllSpeechPractices()
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
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let speechPractices = isSearching ? filteredSpeechPractices : preparedSpeechdataModel.getAllSpeechPractices()
        let selectedSpeech = speechPractices[indexPath.row]

        performSegue(withIdentifier: "showSpeechDetail", sender: selectedSpeech)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSpeechDetail" {
            if let detailVC = segue.destination as? SpeechDetailViewController,
               let speech = sender as? SpeechPractice {
                detailVC.speechPractice = speech
            }
        }
    }

}
