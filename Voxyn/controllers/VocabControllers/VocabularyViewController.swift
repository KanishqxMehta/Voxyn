//
//  VocabularyViewController.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 12/12/24.
//

import UIKit

class VocabularyViewController: UIViewController {

    var selectedWord: VocabularyWord?
    
    @IBOutlet var word: UILabel!
    @IBOutlet var definition: UILabel!
    @IBOutlet var examples: UILabel!
    @IBOutlet var pronunciation: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedWord = selectedWord {
            word.text = selectedWord.word
            definition.text = selectedWord.definition
            pronunciation.text = selectedWord.pronunciation
            // Iterate over examples and format as a single string
            examples.text = selectedWord.examples
                .enumerated()
                .map { "\($0 + 1). \($1)" } // Add numbering
                .joined(separator: "\n")    // Join with newlines
        }

    }
    


}
