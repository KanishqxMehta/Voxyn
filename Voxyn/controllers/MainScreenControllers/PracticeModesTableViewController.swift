//
//  PracticeModesTableViewController.swift
//  ProjMainScr
//
//  Created by Kanishq Mehta on 30/12/24.
//

import UIKit

class PracticeModesTableViewController: UITableViewController {
    
    enum PracticeMode: String, CaseIterable {
        case readAloud = "Read Aloud"
        case randomTopic = "Random Topic"
    }
    
    // MARK: - Genre Model
    struct Genre {
        let name: String
        let iconName: String
        let description: String
    }
    
    struct Topic {
        let topicName: String
        let description: String
    }
    
    // MARK: - Practice Modes Data
    struct PracticeModesData {
        static let readAloudGenres: [Genre] = [
            Genre(name: "News", iconName: "newspaper.fill", description: ""),
            Genre(name: "Business", iconName: "chart.line.uptrend.xyaxis", description: ""),
            Genre(name: "Technology", iconName: "desktopcomputer", description: ""),
            Genre(name: "Lifestyle", iconName: "house.fill", description: ""),
            Genre(name: "Health", iconName: "heart.fill", description: "")
        ]
        
        static let randomTopicGenres: [Genre] = [
            Genre(name: "Personal Experiences", iconName: "person.fill", description: ""),
            Genre(name: "Current Affairs", iconName: "globe", description: ""),
            Genre(name: "Abstract Topics", iconName: "lightbulb.fill", description: ""),
            Genre(name: "Motivational Topic", iconName: "sparkles", description: "")
        ]
        
        static let news: [Topic] = [
            Topic(topicName: "News 1", description: ""),
            Topic(topicName: "News 2", description: ""),
            Topic(topicName: "News 3", description: ""),
            Topic(topicName: "News 4", description: ""),
            Topic(topicName: "News 5", description: "")
        ]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: return PracticeModesData.readAloudGenres.count
        case 1: return PracticeModesData.randomTopicGenres.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "practiceModesCell", for: indexPath)
            cell.imageView?.image = UIImage(systemName: PracticeModesData.readAloudGenres[indexPath.row].iconName)
            cell.textLabel?.text = PracticeModesData.readAloudGenres[indexPath.row].name
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "practiceModesCell", for: indexPath)
            cell.imageView?.image = UIImage(systemName: PracticeModesData.randomTopicGenres[indexPath.row].iconName)
            cell.textLabel?.text = PracticeModesData.readAloudGenres[indexPath.row].name
            return cell
        default:
            return UITableViewCell()
        }
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
            performSegue(withIdentifier: "readAloudSegue", sender: nil)
        case 1: // Random Topic
            performSegue(withIdentifier: "randomTopicSegue", sender: nil)
        default:
            break
        }
    }
}
