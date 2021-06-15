//
//  TabBarUITabBarController.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 30/5/21.
//

import UIKit

class TabBarUITabBarController: UITabBarController {

    @IBOutlet weak var tbBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for item in 0..<3 {
            if let image = tabBar.items?[item].image {
                tabBar.items?[item].image = image.withRenderingMode(.alwaysOriginal)
            }
            tabBar.items?[item].setTitleTextAttributes([.font: UIFont.primary10], for: .normal)
        }
        tbBar?.tintColor = .red
    }

}
