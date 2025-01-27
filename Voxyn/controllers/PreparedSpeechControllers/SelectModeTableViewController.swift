//
//  SelectModeTableViewController.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 20/01/25.
//

import UIKit
import VisionKit

class SelectModeTableViewController: UITableViewController, VNDocumentCameraViewControllerDelegate {

    private var scannedText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Assuming first section, first row (0,0) is "Write Text"
        // and first section, second row (0,1) is "Scan Text"
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // Write Text selected
                performSegue(withIdentifier: "showAddSpeech", sender: nil)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                startScanning()
            }
        }
            
    }

    private func startScanning() {
        guard VNDocumentCameraViewController.isSupported else {
            // Show alert if device doesn't support scanning
            let alert = UIAlertController(
                title: "Scanning Not Supported",
                message: "This device doesn't support document scanning.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let scannerViewController = VNDocumentCameraViewController()
        scannerViewController.delegate = self
        present(scannerViewController, animated: true)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        controller.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            
            // Perform segue with dummy text
            self.performSegue(withIdentifier: "showAddSpeech", sender: nil)
        }
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddSpeech",
           let destinationVC = segue.destination as? AddPreparedSpeechViewController {
            // Pass dummy text to the AddPreparedSpeechViewController
            destinationVC.speechPlaceholder = "This is a dummy text."
        }
    }

}
