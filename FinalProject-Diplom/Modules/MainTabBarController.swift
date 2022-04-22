//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Ilya on 14.02.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    private enum MainTabBarItem {
        case feed
        case profile
        
        var title: String {
            switch self {
            case .feed:
                return "Feed"
            case .profile:
                return "Profile"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .feed:
                return UIImage(systemName: "house.fill")
            case .profile:
                return UIImage(systemName: "person.fill")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let items: [MainTabBarItem] = [.feed, .profile]
        
        self.viewControllers = items.map ({ tabBarItem in
            switch tabBarItem {
            case .profile:
                return UINavigationController(rootViewController: LogInViewController())
            case .feed:
                return UINavigationController(rootViewController: FeedViewController())
            }
        })
        
        self.viewControllers?.enumerated().forEach({(index, vc) in
            vc.tabBarItem.title = items[index].title
            vc.tabBarItem.image = items[index].image
        })
    }
}
