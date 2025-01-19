//
//  RecordingTableViewController.swift
//  Voxyn
//
//  Created by Kanishq Mehta on 19/01/25.
//

import UIKit

class RecordingTableViewController: UITableViewController, UISearchBarDelegate {
    // MARK: - Properties
    let recordingDataModel = RecordingDataModel.shared
    var recordings: [Recording] = []
    var filteredRecordings: [Recording] = []
    var isSearching = false

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    // MARK: - Sections
    enum Section: Int, CaseIterable {
        case readAloud = 0, randomPrompt, preparedSpeech

        var title: String {
            switch self {
            case .readAloud: return "READ ALOUD"
            case .randomPrompt: return "RANDOM PROMPT"
            case .preparedSpeech: return "PREPARED SPEECH"
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup table view
        setupTableView()

        // Load data
        loadData()

        // Setup search bar
        setupSearchBar()
    }

    // MARK: - Setup Methods
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RecordingCell")
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
    }

    private func loadData() {
        // Fetch all recordings
        recordings = recordingDataModel.findRecordings(by: 1) // Replace `1` with the current user ID
        tableView.reloadData()
    }

    // MARK: - TableView Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section(rawValue: section)?.title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filtered = isSearching ? filteredRecordings : recordings
        switch Section(rawValue: section)! {
        case .readAloud:
            return filtered.filter { $0.sessionType == .readAloud }.count
        case .randomPrompt:
            return filtered.filter { $0.sessionType == .randomTopic }.count
        case .preparedSpeech:
            return filtered.filter { $0.sessionType == .preparedSpeech }.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordingCell", for: indexPath)
        let filtered = isSearching ? filteredRecordings : recordings

        let sectionType = Section(rawValue: indexPath.section)!
        let sectionRecordings = filtered.filter { $0.sessionType == sessionType(for: sectionType) }

        let recording = sectionRecordings[indexPath.row]
        cell.textLabel?.text = recording.title
        cell.detailTextLabel?.text = DateFormatter.localizedString(from: recording.timestamp, dateStyle: .long, timeStyle: .none)
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    // MARK: - Helper Methods
    private func sessionType(for section: Section) -> SessionType {
        switch section {
        case .readAloud: return .readAloud
        case .randomPrompt: return .randomTopic
        case .preparedSpeech: return .preparedSpeech
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle row selection
        // Example: Navigate to a detailed view
    }

    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
        } else {
            isSearching = true
            filteredRecordings = recordings.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
}
