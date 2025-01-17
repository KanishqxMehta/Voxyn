//
//  PracticeModesTableViewCell.swift
//  ProjMainScr
//
//  Created by Kanishq Mehta on 30/12/24.
//

import UIKit

class PracticeModesTableViewCell: UITableViewCell {

    @IBOutlet weak var genreIconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
//    init?(coder: NSCoder, genreIconImage: UIImageView!, titleLabel: UILabel!) {
//        super.init(coder: coder)
//        self.genreIconImage = genreIconImage
//        self.titleLabel = titleLabel
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
