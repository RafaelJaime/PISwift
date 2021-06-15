//
//  UINavigationController+extensions.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 1/6/21.
//

import Foundation
import UIKit
import SideMenu
@objc extension UINavigationController {
    func blackBackgroundWithoutSideMenu() {
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.SithLord.white]
        navigationBar.barTintColor = .SithLord.lightDark
        navigationItem.leftBarButtonItem?.tintColor = .SithLord.white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.SithLord.white, NSAttributedString.Key.font: UIFont.primary16]
        navigationBar.tintColor = .SithLord.white
    }
    
    func blackBackground(_ viewController: UIViewController) {
        blackBackgroundWithoutSideMenu()
        let barButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(self.leftBarButtonItemAction))
        barButton.tintColor = .SithLord.white
        navigationBar.topItem?.leftBarButtonItem = barButton
    }
    
    @objc func leftBarButtonItemAction(viewController: UIViewController) {
        let menuController = LateralMenuViewController()
        let navigationController = SideMenuNavigationController(rootViewController: menuController)
        navigationController.leftSide = true
        let newView = navigationBar.topItem?.leftBarButtonItem?.customView
        newView?.transform = CGAffineTransform(rotationAngle: 90 * .pi / 180)
        self.visibleViewController?.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func blackBackgroundtwoButtonItem(_ viewController: UIViewController, button: UIBarButtonItem) {
        blackBackground(viewController)
        navigationBar.topItem?.setRightBarButton(button, animated: true)
    }
    
    @objc func addNotice() {
        print("Add from selector")
    }
    
}
