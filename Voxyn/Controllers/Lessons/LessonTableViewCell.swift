//
//  LessonTableViewCell.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 11/01/25.
//

import UIKit

class LessonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(with lesson: Lesson) {
        titleLabel.text = lesson.title
        durationLabel.text = "\(lesson.duration) min read"
        descriptionLabel.text = lesson.shortDescription
        
        if lesson.isCompleted {
            accessoryType = .checkmark
            tintColor = .systemGreen
        } else {
            accessoryType = .disclosureIndicator
            tintColor = .systemGray
        }
    }

}
