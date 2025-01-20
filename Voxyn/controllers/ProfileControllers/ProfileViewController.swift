//
//  ProfileViewController.swift
//  Voxyn
//
//  Created by Kanishq Mehta on 18/01/25.
//

import UIKit

class ProfileViewController: UIViewController {
    private let bottomSheetView = UIView()
    private let dragHandle = UIView()
    
    var userName: String = "\(UserDataModel.shared.getUser()?.firstName ?? "") \(UserDataModel.shared.getUser()?.lastName ?? "")" // Default name; update it as needed
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 100
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.tintColor = .black
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Voxite"
        label.textColor = .black // Changed to black for better contrast with light background
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Constraints for label
    private var userNameLabelLeadingConstraint: NSLayoutConstraint!
    private var userNameLabelCenterYConstraint: NSLayoutConstraint!
    private var userNameLabelTopConstraint: NSLayoutConstraint!
    
    // New collection view and segmented controls
    private let topSegmentedControl = UISegmentedControl(items: ["Progress", "Acievements"])
    private let gridCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var bottomSheetTopConstraint: NSLayoutConstraint!
    
    // Avatar Constraints
    private var avatarCenterXConstraint: NSLayoutConstraint!
    private var avatarCenterYConstraint: NSLayoutConstraint!
    private var avatarLeadingConstraint: NSLayoutConstraint!
    private var avatarTopConstraint: NSLayoutConstraint!
    private var avatarWidthConstraint: NSLayoutConstraint!
    private var avatarHeightConstraint: NSLayoutConstraint!
    
    private var settingCenterXConstraint: NSLayoutConstraint!
    private var settingCenterYConstraint: NSLayoutConstraint!
    private var settingLeadingConstraint: NSLayoutConstraint!
    private var settingTopConstraint: NSLayoutConstraint!
    private var settingWidthConstraint: NSLayoutConstraint!
    private var settingHeightConstraint: NSLayoutConstraint!

    
    private enum BottomSheetPosition {
        case expanded, collapsed
    }
    
    private let collapsedHeight: CGFloat = 100
    private let expandedHeightMultiplier: CGFloat = 0.82
    
    // Sample data for grid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.secondarySystemBackground
//        view.backgroundColor = UIColor(red: 236/255, green: 247/255, blue: 255/255, alpha: 1.0)

        // Dynamically set the user's name
        userNameLabel.text = userName

        // Setup views in correct order
        setupBottomSheet()
        setupAvatar()
        setupPanGesture()
        setupGridCollectionView()
    }

    // MARK: - Avatar Setup
    private func setupAvatar() {
        view.addSubview(avatarImageView)
        view.addSubview(userNameLabel)
        view.addSubview(settingsButton)
        
        // Add target action for settings button
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        // Avatar constraints with adjusted position
        avatarWidthConstraint = avatarImageView.widthAnchor.constraint(equalToConstant: 200)
        avatarHeightConstraint = avatarImageView.heightAnchor.constraint(equalToConstant: 200)
        avatarCenterXConstraint = avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        avatarCenterYConstraint = avatarImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120)
        avatarLeadingConstraint = avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        avatarTopConstraint = avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24)
        
        // Settings button constraints with larger size
        settingWidthConstraint = settingsButton.widthAnchor.constraint(equalToConstant: 45) // Increased size
        settingHeightConstraint = settingsButton.heightAnchor.constraint(equalToConstant: 45) // Increased size
        let settingsTrailingConstraint = settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7)
        let settingsTopConstraint = settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20)
        
        // Configure settings button
        settingsButton.setImage(UIImage(systemName: "gear")?.withConfiguration(
            UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)), for: .normal) // Larger icon
        
        // Username label constraints
        userNameLabelLeadingConstraint = userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16)
        userNameLabelCenterYConstraint = userNameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        userNameLabelTopConstraint = userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 4)
        let userNameLabelCenterXConstraint = userNameLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor)
        
        NSLayoutConstraint.activate([
            avatarWidthConstraint,
            avatarHeightConstraint,
            avatarCenterXConstraint,
            avatarCenterYConstraint,
            settingWidthConstraint,
            settingHeightConstraint,
            settingsTrailingConstraint,
            settingsTopConstraint,
            userNameLabelTopConstraint,
            userNameLabelCenterXConstraint
        ])
        
        avatarLeadingConstraint.isActive = false
        avatarTopConstraint.isActive = false
        userNameLabelLeadingConstraint.isActive = false
        userNameLabelCenterYConstraint.isActive = false
    }

    @objc private func settingsButtonTapped() {
        // Load the "Profile" storyboard
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        
        // Instantiate the Profile view controller
        if let profileVC = profileStoryboard.instantiateViewController(withIdentifier: "Profile") as? ProfileTableViewController {
            // Ensure there is a navigation controller to push the new screen
            if let navigationController = navigationController {
                navigationController.pushViewController(profileVC, animated: true)
            } else {
                print("Navigation controller not available. Please ensure ViewController is embedded in a UINavigationController.")
            }
        } else {
            print("Failed to instantiate Profile view controller. Check storyboard ID and class.")
        }
    }

    // MARK: - Bottom Sheet Setup
    private func setupBottomSheet() {
        view.addSubview(bottomSheetView) // Add to main view first
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomSheetView.backgroundColor = .white
        bottomSheetView.layer.cornerRadius = 40
        bottomSheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // Add drag handle to bottom sheet
        dragHandle.backgroundColor = .lightGray
        dragHandle.layer.cornerRadius = 3
        dragHandle.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.addSubview(dragHandle)
        
        // Setup Segmented Controls
        topSegmentedControl.selectedSegmentIndex = 0
        topSegmentedControl.backgroundColor = UIColor(red: 236/255, green: 247/255, blue: 255/255, alpha: 1.0)
        topSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 106/255, green: 117/255, blue: 125/255, alpha: 1.0)
        ]
        let activeAttribute: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]
        topSegmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        topSegmentedControl.setTitleTextAttributes(activeAttribute, for: .selected)
        bottomSheetView.addSubview(topSegmentedControl)
        
        // Set up constraints
        bottomSheetTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 2.15)
        
        NSLayoutConstraint.activate([
            bottomSheetTopConstraint,
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dragHandle.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor),
            dragHandle.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 10),
            dragHandle.widthAnchor.constraint(equalToConstant: 60),
            dragHandle.heightAnchor.constraint(equalToConstant: 6),
            
            topSegmentedControl.topAnchor.constraint(equalTo: dragHandle.bottomAnchor, constant: 16),
            topSegmentedControl.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor, constant: 16),
            topSegmentedControl.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Grid Collection View Setup
    var feedback: Feedback = Feedback(
        feedbackId: 1,
        recordingId: 1,
        scores: [
            .clarity: 85,
            .tone: 92,
            .pace: 78,
            .fluency: 88
        ],
        comments: [
            .clarity: "Your pronunciation is becoming more distinct and clear",
            .tone: "Your voice modulation is excellent",
            .pace: "Good rhythm maintained throughout",
            .fluency: "Speaking more naturally"
        ],
        overallComment: "Great improvement overall!"
    )
    
    
    
    private let categories: [FeedbackCategory] = [.clarity, .tone, .pace, .fluency]
    
    private func setupGridCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        gridCollectionView.translatesAutoresizingMaskIntoConstraints = false
        gridCollectionView.backgroundColor = .clear
        gridCollectionView.register(ProgressCardCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCardCollectionViewCell.identifier)
        gridCollectionView.delegate = self
        gridCollectionView.dataSource = self
        bottomSheetView.addSubview(gridCollectionView)
        
        NSLayoutConstraint.activate([
            gridCollectionView.topAnchor.constraint(equalTo: topSegmentedControl.bottomAnchor, constant: 16),
            gridCollectionView.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor, constant: 16),
            gridCollectionView.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor, constant: -16),
            gridCollectionView.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        bottomSheetView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        let maxSheetHeight = view.frame.height * expandedHeightMultiplier
        
        if gesture.state == .changed {
            let newTopConstant = bottomSheetTopConstraint.constant + translation.y
            bottomSheetTopConstraint.constant = max(-maxSheetHeight, min(newTopConstant, -view.frame.height / 1.95))
            gesture.setTranslation(.zero, in: view)
            
            // Calculate progress of sheet expansion
            let progress = 1 - (abs(bottomSheetTopConstraint.constant) / maxSheetHeight)
            updateAvatarLayout(progress: progress)
        }
        
        if gesture.state == .ended {
            // Determine if we should expand or collapse based on velocity and position
            let snapPosition: BottomSheetPosition
            let currentHeight = abs(bottomSheetTopConstraint.constant)
            let threshold = maxSheetHeight / 2
            
            if velocity.y < -500 || (velocity.y > -500 && velocity.y < 500 && currentHeight > threshold) {
                snapPosition = .expanded
            } else {
                snapPosition = .collapsed
            }
            
            animateBottomSheet(to: snapPosition)
        }
    }
    
    private func updateAvatarLayout(progress: CGFloat) {
        let clampedProgress = max(0, min(1, progress))
        
        NSLayoutConstraint.deactivate([
            avatarCenterXConstraint,
            avatarCenterYConstraint,
            avatarLeadingConstraint,
            avatarTopConstraint,
            avatarWidthConstraint,
            avatarHeightConstraint,
            userNameLabelLeadingConstraint,
            userNameLabelCenterYConstraint,
            userNameLabelTopConstraint
        ])
        
        let minSize: CGFloat = 120
        let maxSize: CGFloat = 200
        let currentSize = minSize + (maxSize - minSize) * clampedProgress
        
        if clampedProgress < 1 {
            // Expanded state (smaller avatar with label to the right)
            avatarLeadingConstraint.constant = 0
            avatarTopConstraint.constant = -60
            
            avatarWidthConstraint = avatarImageView.widthAnchor.constraint(equalToConstant: minSize)
            avatarHeightConstraint = avatarImageView.heightAnchor.constraint(equalToConstant: minSize)
            
//            userNameLabelLeadingConstraint = userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.centerXAnchor, constant: 100)
            userNameLabel.isHidden = true
//            userNameLabelCenterYConstraint = userNameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
            
            NSLayoutConstraint.activate([
                avatarLeadingConstraint,
                avatarTopConstraint,
                avatarWidthConstraint,
                avatarHeightConstraint,
//                userNameLabelLeadingConstraint,
                userNameLabelCenterYConstraint
            ])
        } else {
            
            userNameLabel.isHidden = false

            // Collapsed state (centered larger avatar with label below)
            avatarCenterXConstraint = avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            avatarCenterYConstraint = avatarImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120)
            
            avatarWidthConstraint = avatarImageView.widthAnchor.constraint(equalToConstant: maxSize)
            avatarHeightConstraint = avatarImageView.heightAnchor.constraint(equalToConstant: maxSize)
            
            userNameLabelTopConstraint = userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 4)
            let userNameLabelCenterXConstraint = userNameLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor)
            
            NSLayoutConstraint.activate([
                avatarCenterXConstraint,
                avatarCenterYConstraint,
                avatarWidthConstraint,
                avatarHeightConstraint,
                userNameLabelTopConstraint,
                userNameLabelCenterXConstraint
            ])
        }
        
        let scale = currentSize / maxSize
        avatarImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateBottomSheet(to position: BottomSheetPosition) {
        let maxSheetHeight = view.frame.height * expandedHeightMultiplier
        
        switch position {
        case .expanded:
            bottomSheetTopConstraint.constant = -maxSheetHeight
            updateAvatarLayout(progress: 0)
        case .collapsed:
            bottomSheetTopConstraint.constant = -view.frame.height / 1.95
            updateAvatarLayout(progress: 1)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        })
    }
}

// MARK: - UICollectionView Delegate & Data Source
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCardCollectionViewCell.identifier, for: indexPath) as! ProgressCardCollectionViewCell
        
        let category = categories[indexPath.item]
        
        let score = feedback.scores[category] ?? 0
        let comment = feedback.comments?[category]
        cell.configure(category: category, score: score, comment: comment)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 16) // 2 columns with spacing
        return CGSize(width: width, height: 160)
    }
}
