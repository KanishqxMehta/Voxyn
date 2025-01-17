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
    @IBOutlet var completionImage: UIImageView!
    
    func configure(with lesson: Lesson) {
        titleLabel.text = lesson.title
        durationLabel.text = "\(lesson.duration) min read"
        descriptionLabel.text = lesson.shortDescription
        
        if lesson.isCompleted {
            // Set the checkmark image
            completionImage.image = UIImage(systemName: "checkmark.circle")
            
            // Make the image view circular
            completionImage.layer.cornerRadius = completionImage.frame.size.width / 2
            completionImage.clipsToBounds = true
            
            // Set a green background color
            completionImage.backgroundColor = UIColor.systemGreen
            
            // Optional: Add a white tint color for the checkmark
            completionImage.tintColor = UIColor.white
        } else {
            // Reset the image view for incomplete lessons
            completionImage.image = nil
            completionImage.backgroundColor = nil
        }
    }

}
