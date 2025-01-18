//
//  CommunityHubViewController.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 02/01/25.
//

import UIKit

class CommunityHubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private let roomDataModel = RoomDataModel.shared
    private var currentRooms: [Room] = []
    private var isShowingLiveRoomsOnly = false
    private var liveToggleButton: UIBarButtonItem!
    
    private var isShowingRooms: Bool {
        return segmentedControl.selectedSegmentIndex == 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadRooms()
    }
    
    private func setupUI() {
        setupTableView()
        setupNavigationBar()
   }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .secondarySystemBackground
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshRooms), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    private func setupNavigationBar() {
        liveToggleButton = UIBarButtonItem(
            title: isShowingLiveRoomsOnly ? "Show All" : "Live Only",
            style: .plain,
            target: self,
            action: #selector(toggleLiveRooms)
        )
        navigationItem.rightBarButtonItem = liveToggleButton
        updateNavigationBarVisibility()
    }
    
    private func updateNavigationBarVisibility() {
        liveToggleButton.isHidden = !isShowingRooms
    }
    
    private func updateLiveToggleButtonTitle() {
        liveToggleButton.title = isShowingLiveRoomsOnly ? "Show All" : "Live Only"
    }
    
    private func loadRooms() {
        currentRooms = isShowingLiveRoomsOnly ?
            roomDataModel.getLiveRooms() :
            roomDataModel.getAllRooms()
        tableView.reloadData()
    }
    
    @objc private func refreshRooms() {
        loadRooms()
        tableView.refreshControl?.endRefreshing()
    }
    
    @objc private func toggleLiveRooms() {
        isShowingLiveRoomsOnly.toggle()
        updateLiveToggleButtonTitle()
        loadRooms()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segmentedControl.selectedSegmentIndex == 0 ? currentRooms.count : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as! RoomTableViewCell
            let room = currentRooms[indexPath.row]
            cell.configure(with: room)

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell", for: indexPath)
            cell.textLabel?.text = "Feedback"
            cell.imageView?.image = UIImage(systemName: "message")

            return cell
        }
    }
    
    @objc private func enterRoomTapped(_ sender: UIButton) {
        let room = currentRooms[sender.tag]
        joinRoom(room)
    }
    
    private func joinRoom(_ room: Room) {
        if room.participantsJoined < room.totalParticipants {
            roomDataModel.updateRoomParticipants(
                roomTitle: room.title,
                newParticipants: room.participantsJoined + 1
            )
            loadRooms()
        } else {
            showRoomFullAlert()
        }
    }
    
    private func showRoomFullAlert() {
        let alert = UIAlertController(
            title: "Room Full",
            message: "This room has reached its maximum capacity.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateNavigationBarVisibility()
        tableView.reloadData()
    }
}
