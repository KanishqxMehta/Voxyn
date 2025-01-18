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
    @IBOutlet var liveIndicator: UIButton!
    
    func configure(with room: Room) {
        titleLabel.text = room.title
        participantsLabel.text = "\(room.participantsJoined)/\(room.totalParticipants) Participants"
        topicLabel.text = room.topic
        hostLabel.text = room.hostName
        topicImage.image = UIImage(systemName: "tag")
        
        // Configure live indicator
        liveIndicator.isHidden = !room.isLive
        
        // Configure enter button state
        enterRoomButton.isEnabled = room.participantsJoined < room.totalParticipants
        enterRoomButton.alpha = enterRoomButton.isEnabled ? 1.0 : 0.5
    }

}
