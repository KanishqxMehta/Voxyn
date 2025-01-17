//
//  VocabularyTableViewController.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 11/12/24.
//

import UIKit

class VocabularyTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    
    var filteredWords: [Vocabulary] = []
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the delegate for the search bar
        searchBar.delegate = self
        filteredWords = VocabularyDataModel.shared.getAllVocabulary()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredWords.count : VocabularyDataModel.shared.getAllVocabulary().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VocabularyCell", for: indexPath)
        
        let word = isSearching ? filteredWords[indexPath.row] : VocabularyDataModel.shared.getAllVocabulary()[indexPath.row]
        cell.textLabel?.text = word.word
        cell.detailTextLabel?.text = word.pronunciationText
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredWords = VocabularyDataModel.shared.getAllVocabulary()
        } else {
            isSearching = true
            filteredWords = VocabularyDataModel.shared.getAllVocabulary().filter {
                        $0.word.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowVocabularyDetail", sender: indexPath)
    }
    
    // MARK: - Navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "ShowVocabularyDetail",
          let destinationVC = segue.destination as? VocabularyDetailTableViewController,
          let indexPath = tableView.indexPathForSelectedRow {
           let selectedWord = isSearching ? filteredWords[indexPath.row] : VocabularyDataModel.shared.getAllVocabulary()[indexPath.row]
           destinationVC.selectedWordId = selectedWord.id
       }
   }
}
