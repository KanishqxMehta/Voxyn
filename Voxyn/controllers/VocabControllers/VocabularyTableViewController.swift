//
//  VocabularyTableViewController.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 11/12/24.
//

import UIKit

class VocabularyTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    
    var filteredWords: [VocabularyWord] = []
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the delegate for the search bar
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return vocabularyWords.count
        return isSearching ? filteredWords.count : vocabularyWords.count

    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "VocabularyCell", for: indexPath)
//            
//        let word = vocabularyWords[indexPath.row]
//        cell.textLabel?.text = word.word 
//        cell.detailTextLabel?.text = word.pronunciation
//            return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VocabularyCell", for: indexPath)
        
        let word = isSearching ? filteredWords[indexPath.row] : vocabularyWords[indexPath.row]
        cell.textLabel?.text = word.word
        cell.detailTextLabel?.text = word.pronunciation
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredWords = vocabularyWords
        } else {
            isSearching = true
            filteredWords = vocabularyWords.filter {
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

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowVocabularyDetail" {
//            // Get the destination view controller
//            if let destinationVC = segue.destination as? VocabularyViewController,
//               let indexPath = tableView.indexPathForSelectedRow {
//                // Pass the selected word to the destination
//                destinationVC.selectedWord = vocabularyWords[indexPath.row]
//            }
//        }
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowVocabularyDetail" {
            // Get the destination view controller
            if let destinationVC = segue.destination as? VocabularyDetailTableViewController,
               let indexPath = tableView.indexPathForSelectedRow {
                // Pass the selected word to the destination
                destinationVC.selectedWord = vocabularyWords[indexPath.row]
            }
        }
    }

}
