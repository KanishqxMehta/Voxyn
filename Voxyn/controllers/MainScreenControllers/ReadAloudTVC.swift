//
//  ReadAloudTVC.swift
//  ProjMainScr
//
//  Created by Kanishq Mehta on 02/01/25.
//

import UIKit

class ReadAloudTVC: UITableViewController {
    
    struct Topic {
        let topicName: String
        let description: String
    }
    
    let news: [Topic] = [
        Topic(topicName: "News 1", description: ""),
        Topic(topicName: "News 2", description: ""),
        Topic(topicName: "News 3", description: ""),
        Topic(topicName: "News 4", description: ""),
        Topic(topicName: "News 5", description: "")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        content.text = news[indexPath.row].topicName
        
        cell.contentConfiguration = content
        
        
        
        return cell
    }
    
}
