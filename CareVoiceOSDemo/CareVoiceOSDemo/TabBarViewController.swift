//
//  TabBarViewController.swift
//  CareVoiceOSDemo
//
//  Created by way on 2025/9/28.
//

import UIKit
import CVWellness

class TabBarViewController: UITabBarController {
    
    enum TabColors {
        static let selected = UIColor.systemBlue
        static let unselected = UIColor.systemGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        configureAppearance()
    }
    
    func setupTabs() {
        let homeVC = createVC(
            viewController: HomeViewController(),
            title: "Home",
            imageName: "house",
            selectedImageName: "house.fill"
        )
        
        let wellnessVC = createVC(
            viewController: CVWellness.getViewController(false),
            title: "Wellness",
            imageName: "leaf",
            selectedImageName: "leaf.fill"
        )
        
        let profileVC = createVC(
            viewController: ProfileViewController(),
            title: "Profile",
            imageName: "person",
            selectedImageName: "person.fill"
        )
        
        viewControllers = [homeVC, wellnessVC, profileVC]
    }
    
    func createVC(viewController: UIViewController,
                                     title: String,
                                     imageName: String,
                                     selectedImageName: String) -> UINavigationController {
        
        let normalImage = UIImage(systemName: imageName)?
            .withRenderingMode(.alwaysTemplate)
        let selectedImage = UIImage(systemName: selectedImageName)?
            .withRenderingMode(.alwaysTemplate)
        
        let navController = NavigationController(rootViewController: viewController)
        
        navController.tabBarItem = UITabBarItem(
            title: title,
            image: normalImage,
            selectedImage: selectedImage
        )
        
        navController.navigationBar.prefersLargeTitles = false
        
        return navController
    }
    
    func configureAppearance() {
        tabBar.tintColor = TabColors.selected
        tabBar.unselectedItemTintColor = TabColors.unselected
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [.font: UIFont.systemFont(ofSize: 12, weight: .medium)],
            for: .normal
        )
    }
}
