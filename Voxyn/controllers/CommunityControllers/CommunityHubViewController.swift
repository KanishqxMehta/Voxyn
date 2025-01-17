//
//  CommunityHubViewController.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 02/01/25.
//

import UIKit

class CommunityHubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .secondarySystemBackground
        
        // Prevent clipping of shadows
//                tableView.layer.masksToBounds = false
//                tableView.clipsToBounds = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segmentedControl.selectedSegmentIndex == 0 ? rooms.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as! RoomTableViewCell
            let room = rooms[indexPath.row]
            cell.configure(with: room)

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell", for: indexPath)
            cell.textLabel?.text = "Feedback"
            cell.detailTextLabel?.text = "Add your feedback"
            cell.imageView?.image = UIImage(systemName: "message")
            // Configure feedback cell
            return cell
        }
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
            tableView.reloadData()
    }
}
