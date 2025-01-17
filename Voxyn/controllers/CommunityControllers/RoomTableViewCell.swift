//
//  RoomTableViewCell.swift
//  Voxyn
//
//  Created by Gaganveer Bawa on 02/01/25.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var enterRoomButton: UIButton!
    @IBOutlet var topicImage: UIImageView!
    
    func configure(with room: Room) {
        titleLabel.text = room.title
        
        // Display participants in the format: "X/Y Participants"
        participantsLabel.text = "\(room.participantsJoined)/\(room.totalParticipants) Participants"
        
        topicLabel.text = room.topic
        
        // Updated 'host' to 'hostName'
        hostLabel.text = room.hostName
        
        // Set a system image for the topic, could be customized per topic
        topicImage.image = UIImage(systemName: "tag")
    }

}
