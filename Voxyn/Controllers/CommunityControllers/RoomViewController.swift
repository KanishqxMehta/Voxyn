import UIKit

class RoomViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var bottomBarView: UIView!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var speakerButton: UIButton!
    @IBOutlet weak var leaveBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isMicOn = true
    var isSpeakerOn = true
    
    // Array to hold participant data (name, image, mute status)
    var participants: [(name: String, image: UIImage?, isMuted: Bool)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true

        // Set the initial mic and speaker symbols
        micButton.setImage(UIImage(systemName: "mic"), for: .normal)
        speakerButton.setImage(UIImage(systemName: "speaker.wave.2", withConfiguration: UIImage.SymbolConfiguration(hierarchicalColor: .systemBlue)), for: .normal)
        
        // Configure shadow for the bottom bar view
        bottomBarView.layer.shadowColor = UIColor.black.cgColor
        bottomBarView.layer.shadowOffset = CGSize(width: 0, height: -2)
        bottomBarView.layer.shadowOpacity = 0.15
        bottomBarView.layer.shadowRadius = 4
        bottomBarView.layer.masksToBounds = false
        bottomBarView.layer.cornerRadius = 25
        
        // Initialize participants (max 10 with placeholders)
        participants = [
            (name: "Andrey", image: UIImage(systemName: "person.circle"), isMuted: false),
            (name: "Sumaiya", image: UIImage(systemName: "person.circle"), isMuted: true),
            (name: "Noa", image: UIImage(systemName: "person.circle"), isMuted: true),
        ]
        
        // Fill remaining slots with placeholders
        while participants.count < 10 {
            participants.append((name: "Vacant", image: UIImage(systemName: "person.circle.fill"), isMuted: false))
        }
        
        // Configure the collection view
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @IBAction func micBtnTapped(_ sender: UIButton) {
        isMicOn.toggle()
        
        // Determine the new symbol
        let newImage = UIImage(systemName: isMicOn ? "mic" : "mic.slash", withConfiguration: UIImage.SymbolConfiguration(hierarchicalColor: .systemBlue))
        
        // Use a UIView transition to create the animation
        UIView.transition(with: micButton, duration: 0.3, options: [.allowAnimatedContent], animations: {
            self.micButton.setImage(newImage, for: .normal)
        }, completion: nil)
    }
    
    @IBAction func speakerBtnTapped(_ sender: UIButton) {
        isSpeakerOn.toggle()
        
        let newImage = UIImage(systemName: isSpeakerOn ? "speaker.wave.2" : "speaker.slash", withConfiguration: UIImage.SymbolConfiguration(hierarchicalColor: .systemBlue))
        
        UIView.transition(with: speakerButton, duration: 0.3, options: .curveLinear, animations: {
            (sender as AnyObject).setImage(newImage, for: .normal)
        }, completion: nil)
    }
    
    @IBAction func leaveBtnTapped(_ sender: UIButton) {
        // Create an alert controller
        let alert = UIAlertController(title: "Leave Session", message: "Are you sure you want to leave the session?", preferredStyle: .alert)
        
        // Add "Yes" action
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            // Navigate back to the previous screen
            self.navigationController?.popViewController(animated: true)
        }))
        
        // Add "Cancel" action
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Present the alert
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return participants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParticipantCell", for: indexPath) as? ParticipantCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let participant = participants[indexPath.item]
        cell.participantImageView.image = participant.image
        cell.nameLabel.text = participant.name
        cell.muteIconView.isHidden = !participant.isMuted
        cell.bgView.layer.cornerRadius = 20


        // Styling for the cell
        cell.participantImageView.layer.cornerRadius = cell.participantImageView.frame.width / 2
        cell.participantImageView.clipsToBounds = true
        cell.muteIconView.image = UIImage(systemName: "mic.slash.fill")
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideLength = collectionView.frame.width / 3 - 35 // Adjust for spacing
        return CGSize(width: sideLength, height: sideLength)
    }
}
