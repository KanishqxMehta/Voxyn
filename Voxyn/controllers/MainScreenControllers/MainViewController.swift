//
//  MainViewController.swift
//  Voxyn
//
//  Created by Kanishq Mehta on 15/01/25.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController {

    @IBOutlet var roundCornerViews: [UIView]!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet var startButton: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for startButton in startButton {
            startButton.layer.shadowColor = UIColor.black.cgColor  // Shadow color
            startButton.layer.shadowOpacity = 0.3                 // Shadow opacity (0.0 to 1.0)
            startButton.layer.shadowOffset = CGSize(width: 0, height: 0) // Shadow offset
            startButton.layer.shadowRadius = 3                    // Shadow blur radius
            
            // Optional: To make the shadow visible when the button is rounded
            startButton.layer.masksToBounds = false
        }

        
        // Round corners for specific views
        roundCornerViews.forEach { view in
            view.layer.cornerRadius = 8  // Adjust this value to control the roundness
            view.clipsToBounds = true    // Ensures the content stays within rounded bounds
        }
        
        // Set the navigation title with the user's name
        self.navigationItem.title = "Hi, \(UserDataModel.shared.getUser()?.firstName ?? "Guest")"
        
        // Embed the SwiftUI chart into the chartView
        let hostingController = UIHostingController(rootView: ChartView())
        addChild(hostingController) // Add the hosting controller as a child
        chartView.addSubview(hostingController.view) // Add its view to the chartView
        
        // Set up constraints for the hosting controller's view
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: chartView.topAnchor, constant: 10),
            hostingController.view.bottomAnchor.constraint(equalTo: chartView.bottomAnchor, constant: -10),
            hostingController.view.leadingAnchor.constraint(equalTo: chartView.leadingAnchor, constant: 10),
            hostingController.view.trailingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: -10),
        ])
        
        hostingController.didMove(toParent: self) // Notify the hosting controller that it's moved to a parent
    }


    @IBAction func lessonsBtnClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Lessons", bundle: nil) // Replace "OtherStoryboardName" with the name of your storyboard file
        
        // Instantiate the view controller
        if let lessonsVC = storyboard.instantiateViewController(withIdentifier: "Lessons") as? LessonsTableViewController {
            // Navigate to the view controller
            self.navigationController?.pushViewController(lessonsVC, animated: true)
        } else {
            print("Failed to instantiate LessonsViewController. Check its storyboard ID.")
        }
    }
    
    
    @IBAction func vocabBtnClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Vocabulary", bundle: nil) // Replace "OtherStoryboardName" with the name of your storyboard file
        
        // Instantiate the view controller
        if let vocabVC = storyboard.instantiateViewController(withIdentifier: "Vocab") as? VocabularyTableViewController {
            // Navigate to the view controller
            self.navigationController?.pushViewController(vocabVC, animated: true)
        } else {
            print("Failed to instantiate LessonsViewController. Check its storyboard ID.")
        }

    }
}
