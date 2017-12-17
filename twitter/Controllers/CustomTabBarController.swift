//
//  CustomTabBarController.swift
//  twitter
//
//  Created by Paul Dong on 17/12/17.
//  Copyright © 2017 Paul Dong. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavControllerWithTitle(controller: HomeDataSourceController(), title: "Home", image: #imageLiteral(resourceName: "recent")),
            createNavControllerWithTitle(controller: UIViewController(),title: "Notifications", image: #imageLiteral(resourceName: "calls")),
            createNavControllerWithTitle(controller: UIViewController(),title: "Moments", image: #imageLiteral(resourceName: "groups")),
            createNavControllerWithTitle(controller: UIViewController(),title: "Messages", image: #imageLiteral(resourceName: "people")),
            createNavControllerWithTitle(controller: UIViewController(),title: "Me", image: #imageLiteral(resourceName: "settings"))
        ]
    }
    
    private func createNavControllerWithTitle(controller: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
