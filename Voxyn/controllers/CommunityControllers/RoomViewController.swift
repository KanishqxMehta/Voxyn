import UIKit

class RoomViewController: UIViewController {

    @IBOutlet weak var bottomBarView: UIView!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var speakerButton: UIButton!
    @IBOutlet weak var leaveBtn: UIButton!
    
    var isMicOn = true
    var isSpeakerOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.hidesBackButton = true

        // Set the initial mic symbol
        micButton.setImage(UIImage(systemName: "mic"), for: .normal)
        speakerButton.setImage(UIImage(systemName: "speaker.wave.3"), for: .normal)
        
        // Configure shadow for the bottom bar view
        bottomBarView.layer.shadowColor = UIColor.black.cgColor
        bottomBarView.layer.shadowOffset = CGSize(width: 0, height: -2)
        bottomBarView.layer.shadowOpacity = 0.15
        bottomBarView.layer.shadowRadius = 4
        bottomBarView.layer.masksToBounds = false
        bottomBarView.layer.cornerRadius = 25
    }

    @IBAction func micBtnTapped(_ sender: UIButton) {
        isMicOn.toggle()
        
        // Determine the new symbol
        let newImage = UIImage(systemName: isMicOn ? "mic" : "mic.slash")
        
        // Use a UIView transition to create the animation
        UIView.transition(with: micButton, duration: 0.3, options: [.allowAnimatedContent], animations: {
            self.micButton.setImage(newImage, for: .normal)
        }, completion: nil)
    }
    
    @IBAction func speakerBtnTapped(_ sender: UIButton) {
        isSpeakerOn.toggle()
        
        let newImage = UIImage(systemName: isSpeakerOn ? "speaker.wave.3" : "speaker.slash")
        
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
}
