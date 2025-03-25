//
//  LessonsTableViewController.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 11/01/25.
//

import UIKit

class LessonsTableViewController: UITableViewController, UISearchBarDelegate, LessonDetailDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
//    let lessons = LessonDataModel.shared.getAllLessons()
    private var lessons: [Lesson] = []
    private var filteredLessons: [Lesson] = []
    private var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Search bar
        searchBar.delegate = self
        reloadLessonData()
    }
    
    private func reloadLessonData() {
        lessons = LessonDataModel.shared.getAllLessons()
        filteredLessons = lessons
        tableView.reloadData()
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
            destinationVC.delegate = self
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func didUpdateLessonCompletion(_ lesson: Lesson) {
        // Update the lessons array
        if let index = lessons.firstIndex(where: { $0.lessonId == lesson.lessonId }) {
            lessons[index] = lesson
        }

        // Update the filtered list
        if isSearching {
            filteredLessons = lessons.filter { $0.title.lowercased().contains(searchBar.text?.lowercased() ?? "") }
        } else {
            filteredLessons = lessons
        }

        // Reload the table view
        tableView.reloadData()
    }


}
