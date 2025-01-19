//
//  PracticeModesTableViewController.swift
//  ProjMainScr
//
//  Created by Kanishq Mehta on 30/12/24.
//

import UIKit

class PracticeModesTableViewController: UITableViewController {
    
    private let readAloudDataModel = ReadAloudDataModel.shared
    private let randomTopicDataModel = RandomTopicDataModel.shared
    
    private var randomTopicGenres: [Genre] = []
    private var readAloudGenres: [Genre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    private func loadData() {
        readAloudGenres = readAloudDataModel.getAllGenres()
        randomTopicGenres = randomTopicDataModel.getAllGenres()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: return readAloudGenres.count
        case 1: return randomTopicGenres.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeModesCell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            let genre = readAloudGenres[indexPath.row]
            cell.imageView?.image = UIImage(systemName: genre.iconName)
            cell.textLabel?.text = genre.name
        case 1:
            let genre = randomTopicGenres[indexPath.row]
            cell.imageView?.image = UIImage(systemName: genre.iconName)
            cell.textLabel?.text = genre.name
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Read Aloud"
        case 1: return "Random Topic"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.section {
        case 0: // Read Aloud
            performSegue(withIdentifier: "readAloudSegue", sender: indexPath)
        case 1: // Random Topic
            performSegue(withIdentifier: "randomTopicSegue", sender: indexPath)
        default:
            break
        }
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath else { return }
        
        switch segue.identifier {
        case "readAloudSegue":
            if let destinationVC = segue.destination as? ReadAloudTVC {
                // Convert selected Genre back to ReadAloudGenre enum
                let selectedGenre = ReadAloudGenre.allCases[indexPath.row]
                // Get all passages for this genre
                let passages = readAloudDataModel.getPassages(for: selectedGenre)
                // Configure the destination view controller
                destinationVC.passages = passages
                destinationVC.selectedGenre = selectedGenre
            }
            
        case "randomTopicSegue":
            if let destinationVC = segue.destination as? RandomTopicTVC {
                // Convert selected Genre back to RandomTopicGenre enum
                let selectedGenre = RandomTopicGenre.allCases[indexPath.row]
                // Get all topics for this genre
                let topics = randomTopicDataModel.getTopics(for: selectedGenre)
                // Configure the destination view controller
                destinationVC.topics = topics
                destinationVC.selectedGenre = selectedGenre
            }
            
        default:
            break
        }
    }
}
