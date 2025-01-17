//
//  LessonsTableViewController.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 11/01/25.
//

import UIKit

class LessonsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    let lessons = LessonDataModel.shared.getAllLessons()
    
    private var filteredLessons: [Lesson] = []
    private var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Search bar
        searchBar.delegate = self
        
        // Initialize filtered array
        filteredLessons = lessons
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredLessons = lessons
        } else {
            isSearching = true
            filteredLessons = lessons.filter { lesson in
                lesson.title.lowercased().contains(searchText.lowercased()) ||
                lesson.shortDescription.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        isSearching = false
        filteredLessons = lessons
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredLessons.count : lessons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as! LessonTableViewCell
        let lesson = isSearching ? filteredLessons[indexPath.row] : lessons[indexPath.row]
        cell.configure(with: lesson)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowLessonDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowLessonDetail",
           let destinationVC = segue.destination as? LessonDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            let lesson = isSearching ? filteredLessons[indexPath.row] : lessons[indexPath.row]
            destinationVC.lesson = lesson
        }
    }
}
