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
        print("Scan completed with \(scan.pageCount) pages")  // Debug print
        
        controller.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            
            print("Scanner dismissed")  // Debug print
            
            let recognizer = TextRecognizer()
            recognizer.recognizeText(from: scan) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let scannedText):
                    print("Successfully recognized text: \(scannedText)")  // Debug print
                    self.scannedText = scannedText
                    DispatchQueue.main.async {
                        print("Performing segue with scanned text")  // Debug print
                        self.performSegue(withIdentifier: "showAddSpeech", sender: nil)
                    }
                    
                case .failure(let error):
                    print("Recognition failed: \(error.localizedDescription)")  // Debug print
                    DispatchQueue.main.async {
                        let alert = UIAlertController(
                            title: "Scanning Failed",
                            message: error.localizedDescription,
                            preferredStyle: .alert
                        )
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddSpeech",
           let destinationVC = segue.destination as? AddPreparedSpeechViewController {
            // If we have scanned text, pass it to the AddPreparedSpeechViewController
            if let scannedText = scannedText {
                destinationVC.speechPlaceholder = scannedText
            }
        }
    }

}

import Vision
import VisionKit

class TextRecognizer {
    func recognizeText(from scan: VNDocumentCameraScan, completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            var allText = ""
            
            for pageIndex in 0..<scan.pageCount {
                print("Processing page \(pageIndex + 1) of \(scan.pageCount)")  // Debug print
                // ... rest of your code ...
                
                let request = VNRecognizeTextRequest { request, error in
                    if let error = error {
                        print("Recognition error: \(error.localizedDescription)")  // Debug print
                        completion(.failure(error))
                        return
                    }
                    
                    guard let observations = request.results as? [VNRecognizedTextObservation] else {
                        print("No text observations found")  // Debug print
                        return
                    }
                    
                    let pageText = observations.compactMap { observation in
                        observation.topCandidates(1).first?.string
                    }.joined(separator: "\n")
                    
                    print("Recognized text for page \(pageIndex + 1): \(pageText)")  // Debug print
                    allText += pageText + "\n\n"
                }
                // ... rest of your code ...
            }
            
            print("Final recognized text: \(allText)")  // Debug print
            completion(.success(allText.trimmingCharacters(in: .whitespacesAndNewlines)))
        }
    }
}
