//
//  MainViewController.swift
//  Voxyn
//
//  Created by Kanishq Mehta on 15/01/25.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Hi, Voxyn"
        print("View Did Load for \(self)")

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
