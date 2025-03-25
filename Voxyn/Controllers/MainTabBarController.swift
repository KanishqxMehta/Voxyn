//
//  MainTabBarController.swift
//  Voxyn
//
//  Created by Kanishq Mehta on 16/01/25.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white // Or any color you'd like for the tab bar background

        if let viewControllers = self.viewControllers {
            let mainVC = viewControllers[0]
            mainVC.tabBarItem.title = "Voxyn"
            mainVC.tabBarItem.image = UIImage(systemName: "mic")
            mainVC.tabBarItem.selectedImage = UIImage(systemName: "mic.fill")
            
            let communityHubVC = viewControllers[1]
            communityHubVC.tabBarItem.title = "Community"
            communityHubVC.tabBarItem.image = UIImage(systemName: "person.3")
            communityHubVC.tabBarItem.selectedImage = UIImage(systemName: "person.3.fill")
            
            let preparedSpeechVC = viewControllers[2]
            preparedSpeechVC.tabBarItem.title = "My Speech"
            preparedSpeechVC.tabBarItem.image = UIImage(systemName: "book.pages")
            preparedSpeechVC.tabBarItem.selectedImage = UIImage(systemName: "book.pages.fill")
            
            let profileVC = viewControllers[3]
            profileVC.tabBarItem.title = "Profile"
            profileVC.tabBarItem.image = UIImage(systemName: "person")
            profileVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
            
//            let profileVC = ProfileViewController()
//            profileVC.title = "Profile" // Set the title for the navigation bar
//            
//            // Embed ProfileViewController in a UINavigationController
//            let profileNavController = UINavigationController(rootViewController: profileVC)
//            profileNavController.tabBarItem = UITabBarItem(
//                title: "Profile",
//                image: UIImage(systemName: "person"),
//                selectedImage: UIImage(systemName: "person.fill")
//            )
//            
//            // Add the ProfileViewController as the 4th tab
//            if var viewControllers = self.viewControllers {
//                viewControllers.append(profileNavController) // Add the profile navigation controller
//                self.viewControllers = viewControllers // Update the tab bar's view controllers
//            }
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
