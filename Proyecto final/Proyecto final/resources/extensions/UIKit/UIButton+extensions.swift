//
//  UIButton+extensions.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 12/6/21.
//

import UIKit

extension UIButton {
    func bottomStyle(color: UIColor = UIColor.lightsaber.blue, title: String) {
        titleLabel?.font = .primary14
        backgroundColor = color
        self.setTitle(title, for: .normal)
        titleLabel?.tintColor = .white
    }
    
    func normalStyle(color: UIColor = UIColor.lightsaber.blue) {
        backgroundColor = color
        titleLabel?.tintColor = .white
        layer.cornerRadius = 5
    }
}
