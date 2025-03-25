//
//  VocabularyResultsViewController.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 29/12/24.
//

import UIKit

class VocabularyResultsViewController: UIViewController {

    @IBOutlet weak var scoreCircleView: UIView!
    @IBOutlet weak var feedbackCardView: UIView!
    @IBOutlet weak var breakdownCardView: UIView!
    @IBOutlet weak var suggestionsCardView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScoreCircle()
        setupCards()
    }
    
    private func setupScoreCircle() {
        scoreCircleView.layer.cornerRadius = scoreCircleView.frame.width / 2
        scoreCircleView.layer.borderWidth = 10
        scoreCircleView.layer.borderColor = UIColor.systemGreen.cgColor
        scoreCircleView.backgroundColor = .clear
        
        scoreLabel.textColor = .systemGreen
        scoreLabel.font = .systemFont(ofSize: 48, weight: .bold)
    }
    
    private func setupCards() {
        // Setup card views
        [feedbackCardView, breakdownCardView, suggestionsCardView].forEach { view in
            view?.layer.cornerRadius = 10
            view?.layer.shadowColor = UIColor.black.cgColor
            view?.layer.shadowOpacity = 0.1
            view?.layer.shadowRadius = 2
            view?.layer.shadowOffset = CGSize(width: 0, height: 2)
            view?.backgroundColor = .systemBackground
        }
    }

}
