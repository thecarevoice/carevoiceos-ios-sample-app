//
//  NavigationController.swift
//  CareVoiceOSDemo
//
//  Created by way on 2025/9/28.
//

import UIKit

class NavigationController: UINavigationController {
    
    lazy var backBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(named: "back_arrow")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        interactivePopGestureRecognizer?.delegate = self
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 14, weight: .bold),
            .foregroundColor: UIColor.colorWithSemantic("text color/text-primary")
        ]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.setLeftBarButton(backBarButtonItem, animated: true)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        if viewControllers.count >= 1 {
            viewControllers.last?.hidesBottomBarWhenPushed = true
            viewControllers.last?.navigationItem.setLeftBarButton(backBarButtonItem, animated: true)
        }
        super.setViewControllers(viewControllers, animated: animated)
    }
}

extension NavigationController {
    
    @objc private func back() {
        popViewController(animated: true)
    }
}

extension NavigationController: UIGestureRecognizerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = true
        if (navigationController.viewControllers.count == 1) {
            interactivePopGestureRecognizer?.isEnabled = false
        }
    }
}

