//
//  RandomTopicTVC.swift
//  ProjMainScr
//
//  Created by Kanishq Mehta on 02/01/25.
//

import UIKit

class RandomTopicTVC: UITableViewController {

    // MARK: - Properties
    var topics: [RandomTopic] = [] // Passed from the segue
    var selectedGenre: RandomTopicGenre? // To display genre-specific details
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title to the selected genre's name
        if let selectedGenre = selectedGenre {
            title = selectedGenre.rawValue
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return topics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RandomTopicCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = topics[indexPath.row].title // Display the title of each topic
        cell.contentConfiguration = content
        return cell
    }
    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "SpeakingTasks", bundle: nil)
        if let speakingTaskVC = storyboard.instantiateViewController(withIdentifier: "SpeakingTasks") as? PracticeViewController {
            speakingTaskVC.dataType = .randomTopic
            speakingTaskVC.selectedData = topics[indexPath.row] // Pass the selected topic
            navigationController?.pushViewController(speakingTaskVC, animated: true)
        } else {
            print("Failed to instantiate SpeakingTasks. Check its storyboard ID.")
        }
    }

}
